# ADR-004 — Estrutura de pastas por domínio e camadas

- **Status:** Aceito (pasta `infra` e entrypoints substituídos pelo ADR-020)
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard

## Contexto

É preciso decidir onde fica cada tipo de arquivo, em especial se a service fica
dentro ou fora da pasta do domínio, e como as dependências são montadas sem acoplar
as camadas.

## Decisão

### Estrutura

```
Backend-CromoCard/
├── database/                    schema.prisma, migrations/, seeds/  (ADR-003)
├── src/
│   ├── domains/
│   │   ├── auth/
│   │   ├── users/
│   │   │   ├── users.routes.ts        URL → middlewares → controller
│   │   │   ├── users.controller.ts    HTTP: lê req, chama service, responde
│   │   │   ├── users.service.ts       regras de negócio
│   │   │   ├── users.service.spec.ts  teste unitário ao lado do arquivo
│   │   │   ├── users.repository.ts    acesso ao banco (Prisma)
│   │   │   ├── users.validator.ts     schemas Zod de body/params/query + tipos (ADR-006)
│   │   │   ├── users.errors.ts        erros do domínio (UserNotFoundError…)
│   │   │   ├── users.swagger.ts       documentação OpenAPI do domínio
│   │   │   └── users.module.ts        monta as dependências e expõe o router e a service
│   │   ├── catalog/
│   │   ├── collection/
│   │   ├── community/
│   │   ├── chat/
│   │   ├── marketplace/               domínio grande → subdomínios com a mesma estrutura
│   │   │   ├── listings/
│   │   │   ├── orders/
│   │   │   └── payments/
│   │   ├── notifications/
│   │   └── admin/
│   ├── shared/                  reutilizável, SEM regra de negócio
│   │   ├── errors/              AppError (base) + errorHandler global
│   │   ├── middlewares/         authenticate, authorize(roles), validate(schema), rateLimit
│   │   ├── utils/               paginação, datas, slug, hash de token…
│   │   └── types/
│   ├── infra/                   tudo que fala com o mundo de fora
│   │   ├── database/            instância única do PrismaClient
│   │   ├── http/                app.ts (Express) e routes.ts (junta os routers)
│   │   ├── realtime/            servidor WebSocket (ADR-007)
│   │   ├── jobs/                cron (ADR-010)
│   │   ├── providers/           cep, mail, storage, payment, shipping (ADR-009)
│   │   ├── docs/                montagem do Swagger
│   │   └── logger.ts
│   ├── config/env.ts            lê e valida variáveis de ambiente com Zod
│   ├── server.ts                entrypoint da API
│   └── realtime.ts              entrypoint do WebSocket
└── tests/
    ├── integration/             rotas de ponta a ponta (supertest + banco de teste)
    └── helpers/                 factories e setup
```

### Camadas e regras

```
rota → middlewares → controller → service → repository → Prisma
```

| Camada | Faz | Não faz |
|---|---|---|
| routes | liga URL, middlewares e controller | lógica |
| controller | traduz HTTP ↔ service (status code, formato da resposta) | regra de negócio, acesso ao banco |
| service | regras de negócio, lança erros do domínio | conhecer `req`/`res`/Express |
| repository | queries Prisma | regras |

1. **A service fica dentro do domínio.** Tudo o que muda junto fica junto (coesão).
2. **Um domínio não importa o repository de outro.** Se precisar de algo de outro
   domínio, usa a service que o `.module.ts` desse domínio exporta.
3. **Dependências entram pelo construtor** (injeção de dependência): a service recebe
   o repository, e o controller recebe a service. Nenhuma classe faz `new` das
   próprias dependências.
4. **Arquivos planos dentro do domínio.** Só se cria subpasta quando o domínio vira
   subdomínios (ex.: marketplace).
5. Nomes de arquivo: `<dominio>.<papel>.ts`, em inglês e minúsculo.

### Por que existe o `.module.ts`

Alguém precisa fazer os `new` e ligar as peças. Esse lugar é a **composition root**
do domínio:

```ts
// users.module.ts
const usersRepository = new UsersRepository(prisma);
const usersService    = new UsersService(usersRepository);
const usersController = new UsersController(usersService);

export const usersRouter = buildUsersRoutes(usersController);
export { usersService };   // API pública do domínio para os outros módulos
```

Sem ele, os `new` acabam dentro do controller ou da service, e a classe fica presa a
uma implementação concreta, o que impede passar um repository falso no teste. A
outra opção seria um `routes.ts` gigante que monta tudo, e aí todo mundo edita o
mesmo arquivo. O `.module.ts` também serve de "porta da frente": o que ele não
exporta, os outros domínios não usam.

## Alternativas consideradas

- **Pastas por camada na raiz** (`src/controllers`, `src/services`…): cada feature
  fica espalhada por 5 pastas e o acoplamento entre domínios fica invisível.
- **Container de injeção de dependência** (tsyringe, inversify): esconde a ligação
  entre as peças atrás de decorators. A montagem manual é mais didática e suficiente
  para o tamanho do projeto.
- **Pasta `model/` por domínio:** o Prisma já gera os tipos das entidades, e os tipos
  de entrada saem do validator. Uma classe de model só se justifica se surgir uma
  regra rica de entidade.

## Consequências

- Criar um domínio novo = copiar a estrutura do `users/` e registrar o router em `infra/http/routes.ts`.
- Os testes unitários da service usam um repository falso sem nenhum framework de mock especial.
- Precisa de disciplina no code review para as regras 2 e 3.
