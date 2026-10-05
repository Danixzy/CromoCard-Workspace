# ADR-014 — Identificadores: UUID v7

- **Status:** Aceito
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard
- **Substitui parcialmente:** ADR-003 (o exemplo `BigInt @default(autoincrement())`)

## Contexto

O DER usava `bigint` auto-incremento em todas as PKs. Isso gera dois problemas:

1. O Prisma devolve `bigint` como `BigInt` do JavaScript, e o `JSON.stringify` **não
   sabe serializar** esse tipo. Toda resposta precisaria de um conversor global.
2. IDs sequenciais aparecem em URLs públicas (perfil, anúncio, grupo). Qualquer pessoa
   consegue enumerar (`/users/1`, `/users/2`...) e estimar quantos usuários e pedidos existem.

## Opções avaliadas

| Opção | Prós | Contras |
|---|---|---|
| **`bigint`** serializado como string | Mantém o DER; comporta qualquer volume | Precisa de conversor global de `BigInt`; IDs enumeráveis |
| **`int`** | O mais simples: o Prisma devolve `number`; IDs curtos, fáceis de depurar | IDs enumeráveis; limite de 2,1 bilhões (suficiente para o projeto) |
| **UUID v7** | Não enumerável; **ordenado por tempo** (índice B-tree quase tão eficiente quanto o de um int, diferente do UUID v4 aleatório, que fragmenta o índice); pode ser gerado antes do insert (ex.: nomear o arquivo no S3); vira `string` no JSON | 16 bytes em vez de 4 ou 8; URLs mais longas; menos prático para digitar ao depurar |
| **Híbrido** (`int` interno + `public_id` UUID) | Junta as vantagens dos dois | Dois identificadores por tabela: complexidade desnecessária |

## Decisão

Usar **UUID v7** como chave primária de todas as entidades com `id`, e `uuid` em todas
as FKs. As tabelas associativas continuam com PK composta pelas FKs.

- **Banco:** `id UUID PRIMARY KEY DEFAULT uuidv7()`. A função `uuidv7()` é nativa a partir do
  **PostgreSQL 18**, então essa passa a ser a versão mínima (imagem `postgres:18` no docker-compose).
- **Prisma:**
  ```prisma
  model User {
    id String @id @default(uuid(7)) @db.Uuid
    @@map("users")
  }
  ```
  Em geral quem gera o ID é o Prisma, e o `DEFAULT` do banco cobre inserts feitos por SQL puro e seeds.
- **Validação:** todo `:id` de rota é validado como UUID no validator (Zod). Um ID
  malformado responde `400`, e não um erro do banco.
- **API:** IDs trafegam como string (`"id": "0192f7a4-6c1e-7b3a-9d2f-4e8b1c0a5f21"`).

## Consequências

- Resolve o problema de serialização do `BigInt` sem código extra.
- Os IDs não revelam volume nem permitem enumeração. **A checagem de permissão continua
  obrigatória:** o UUID dificulta adivinhar um ID, mas não substitui a autorização.
- DER atualizado: todas as PKs `uuid` com default `uuidv7()` e todas as FKs `uuid`.
- Ordenação "mais recentes primeiro" pode usar o próprio `id`, porque o UUID v7 é
  ordenado por tempo. Isso é útil na paginação por cursor do chat (ADR-011).
