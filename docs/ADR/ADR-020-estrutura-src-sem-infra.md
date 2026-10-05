# ADR-020 — Estrutura do `src` sem a pasta `infra`

- **Status:** Aceito
- **Data:** 2026-09-30
- **Decisores:** Equipe CromoCard
- **Substitui parcialmente:** ADR-004 (a pasta `src/infra/` e a localização dos entrypoints)

## Contexto

O ADR-004 agrupava tudo que "fala com o mundo de fora" numa pasta `src/infra/` (banco, http,
realtime, jobs, docs, providers, logger). A equipe achou a pasta genérica e pouco comum em
projetos Express, e preferiu o `app.ts` na raiz do `src`.

Foram avaliadas três alternativas: pastas por responsabilidade na raiz do `src`, uma pasta
`core/` (estilo NestJS/Angular) e mover tudo para o `shared/`.

## Decisão

Cada responsabilidade vira uma pasta própria na raiz do `src`:

```
src/
├── app.ts          cria o Express (middlewares globais, rotas, 404, errorHandler)
├── server.ts       sobe a API e faz o encerramento gracioso
├── routes.ts       registra os módulos de domínio em /api/v1, /health e /docs
├── config/         env.ts, logger.ts, swagger.ts
├── lib/            instâncias e configuração de bibliotecas: prisma.ts, jwt.ts, zod.ts
├── domains/        regras de negócio, um módulo por domínio (ADR-004)
├── shared/         errors/, middlewares/, utils/, types/ — sem regra de negócio
├── providers/      mail/, storage/, zip-code/, payment/, shipping/ (ADR-009)
├── jobs/           cron (ADR-010)
└── socket/         Socket.IO (ADR-007/012)
```

- `database/` continua na raiz do repositório (schema, migrations e seeds — ADR-003).
- As regras de dependência do ADR-004 continuam valendo: `shared/` não importa domínios, e um
  domínio não importa o repository de outro.

## Alternativas consideradas

- **Pasta `core/`:** raiz mais enxuta, mas `core` continua sendo uma caixa genérica, com o mesmo
  problema da `infra`.
- **Tudo no `shared/`:** o `shared/` viraria uma gaveta que mistura utilitários com e-mail, cron
  e socket, quebrando a regra de que ele não fala com o mundo externo.

## Consequências

- O nome de cada pasta diz o que tem dentro, e o ponto de entrada (`app.ts`) fica visível.
- A raiz do `src` tem mais itens (cerca de 10), o que é aceitável.
