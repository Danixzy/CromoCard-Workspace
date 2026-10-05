# ADR-011 — Convenções da API REST

- **Status:** Aceito
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard

## Contexto

Três clientes (web, mobile e BackOffice) consomem a mesma API, e seis pessoas vão
escrever endpoints. Sem um padrão, cada domínio responde num formato diferente.

## Decisão

### URLs
- Prefixo e versão na URL: **`/api/v1`**. Uma mudança incompatível cria `/api/v2`.
- Recursos em inglês, **plural**, `kebab-case`: `/api/v1/albums`, `/api/v1/group-messages`.
- Recursos aninhados só até 1 nível: `/api/v1/albums/:albumId/cards`.
- Recursos do usuário logado ficam em **`/me`**: `/api/v1/me/collection`, `/api/v1/me/notifications`.
- Mudança de estado que não é um CRUD simples vira uma **ação** com `POST`:
  `POST /api/v1/listings/:id/pause`, `POST /api/v1/listings/:id/reactivate`.
- Rotas de apoio: `GET /health` (sem prefixo) e `/docs` (Swagger, fora de produção).

### Métodos e status HTTP
| Situação | Resposta |
|---|---|
| `GET` com sucesso | `200` |
| `POST` que cria | `201` + recurso criado |
| `PATCH` com sucesso | `200` + recurso atualizado |
| `DELETE` com sucesso | `204` sem corpo |
| Validação de entrada (Zod) | `400` |
| Sem token / token inválido | `401` |
| Autenticado, mas sem permissão | `403` |
| Recurso não existe (ou o usuário não pode saber que existe) | `404` |
| Conflito (e-mail já cadastrado, carta já na coleção) | `409` |
| Regra de negócio violada (estoque insuficiente, anúncio pausado) | `422` |
| Limite de requisições | `429` |
| Erro inesperado | `500` (sem stack trace na resposta) |

Use `PATCH` (atualização parcial). `PUT` não é usado.

### Formato das respostas
- JSON com chaves em **camelCase** (o Prisma converte do `snake_case` do banco).
- Sucesso com um item: `{ "data": { ... } }`
- Sucesso com lista:
  ```json
  { "data": [ ... ], "meta": { "page": 1, "pageSize": 20, "total": 134, "totalPages": 7 } }
  ```
- Erro (ADR-006): `{ "error": "LISTING_OUT_OF_STOCK", "message": "Quantidade indisponível", "details": [...] }`.
  O `error` é um código estável em inglês (`UPPER_SNAKE_CASE`), que o frontend pode
  usar em `if`. O `message` é texto em pt-BR para exibir ao usuário.

### Paginação, filtros e ordenação
- **Offset** (padrão): `?page=1&pageSize=20` (máx. 100).
- **Cursor** para feeds que crescem enquanto o usuário lê (mensagens de chat e de
  grupo, notificações): `?cursor=<id>&limit=50`, com resposta `meta: { nextCursor }`.
- Busca textual: `?q=pikachu`. Filtros pelo nome do campo: `?rarityId=3&languageId=1`.
- Ordenação: `?sort=price` (crescente) e `?sort=-price` (decrescente), com uma lista
  de campos permitidos por endpoint.

### Tipos de dados
- Datas em **ISO 8601 UTC** (`2026-09-28T21:15:00Z`). O fuso horário é aplicado no frontend.
- Valores monetários como **string decimal** (`"12.50"`), para evitar erro de ponto
  flutuante. O Prisma já devolve `Decimal`.
- IDs: UUID v7 como string (ADR-014).

## Alternativas consideradas

- **Resposta sem envelope** (o objeto direto): é mais enxuta, mas a lista não tem
  onde colocar a paginação, e cada domínio acaba inventando um jeito.
- **Versão por header** (`Accept: application/vnd...`): mais difícil de testar no
  navegador e no Swagger.
- **GraphQL:** poderoso para três clientes diferentes, mas é mais uma tecnologia para
  aprender, e o C4 define REST.

## Consequências

- Um helper em `shared/utils` padroniza `ok()`, `created()` e `paginated()`, e o
  `errorHandler` padroniza os erros.
- O frontend pode ter um cliente HTTP único que sabe ler `data`, `meta` e `error`.
