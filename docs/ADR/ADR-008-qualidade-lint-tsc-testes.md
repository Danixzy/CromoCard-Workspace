# ADR-008 — Qualidade: ESLint, Prettier, `tsc` e testes `.spec` com cobertura

- **Status:** Aceito
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard

## Contexto

Seis pessoas vão escrever código no mesmo repositório. O code review do projeto
cobra Clean Code, SOLID e Object Calisthenics. É preciso garantir estilo, tipos e
testes de forma automática.

## Decisão

- **ESLint** (flat config, `eslint.config.mjs`) com `typescript-eslint` no modo
  *type-checked*, mais regras de import (sem ciclos, ordem).
- **Prettier** para formatação. O ESLint não opina sobre formatação.
- **`tsc --noEmit`** como etapa de checagem de tipos.
- **husky + lint-staged:** lint e format nos arquivos alterados antes de cada commit.
- **Testes com Vitest:**
  - **unitários** `*.spec.ts` ao lado do arquivo testado, principalmente das services,
    com o repository falso injetado pelo construtor;
  - **integração** em `tests/integration/`, com `supertest` e um banco PostgreSQL de teste;
  - cobertura com `@vitest/coverage-v8` e **limite mínimo de 80%** em
    `src/domains/**/*.service.ts`. Abaixo disso, o CI falha.
- **CI** (Azure Pipelines ou GitHub Actions): `lint` → `typecheck` → `test:cov` → `build`.

Scripts do `package.json`: `dev`, `build`, `start`, `lint`, `format`, `typecheck`,
`test`, `test:watch`, `test:cov`, `db:migrate`, `db:seed`.

### Vitest × Jest

| | Vitest | Jest |
|---|---|---|
| TypeScript | Nativo (esbuild), sem configuração extra | Precisa de `ts-jest` ou Babel |
| ESM (`import`/`export`) | Nativo | Suporte ainda experimental |
| Velocidade | Mais rápido, principalmente no modo watch | Mais lento em projetos TS |
| API | `describe`/`it`/`expect` iguais; `vi.fn()` no lugar de `jest.fn()` | Padrão de mercado há anos |
| Cobertura | Embutida (`--coverage`, v8) | Embutida |
| Material de estudo | Menos, mas crescendo | Muito mais tutoriais e respostas |

**Escolhido: Vitest.** O backend é um projeto novo, 100% TypeScript e ESM, que é justamente
o cenário em que o Jest exige mais configuração (`ts-jest`/SWC, flag experimental de
ESM, aliases repetidos). O Vitest roda TypeScript sem configuração, tem watch mode
rápido (o que incentiva rodar os testes o tempo todo) e é o executor natural do
frontend web (React + Vite).

Quem conhece Jest consegue usar o Vitest, porque a API é quase idêntica
(`jest.fn()` → `vi.fn()`, `jest.mock()` → `vi.mock()`).

**Observação sobre o mobile:** o app React Native (C4) ainda é uma sugestão, não uma
decisão. Se ele for confirmado, provavelmente usará **Jest**, que é o padrão do React
Native. Isso não afeta o backend, e a semelhança entre as APIs mantém o custo de
alternar entre os dois baixo.

## Consequências

- Commits com erro de lint não entram.
- A cobertura mede o que importa (regras de negócio), e não controllers e rotas triviais.
