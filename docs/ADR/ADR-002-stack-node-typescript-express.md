# ADR-002 — Stack: Node.js 24 LTS + TypeScript + Express 5

- **Status:** Aceito
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard

## Contexto

O diagrama C4 (nível 2) define a API como **Node.js + Express + Prisma**. A equipe
precisa de tipagem para trabalhar com segurança num código compartilhado por 6 pessoas.

## Decisão

- **Node.js 24 LTS** (versão fixada em `.nvmrc` e em `engines` no `package.json`).
- **TypeScript** com `strict: true`. O build é feito com `tsc`, e o `tsc --noEmit`
  roda no CI como checagem de tipos.
- **Express 5** como framework HTTP. A versão 5 repassa automaticamente os erros de
  handlers `async` para o middleware de erro, então os controllers não precisam de `try/catch`.
- Segurança HTTP básica: `helmet`, `cors` (com lista de origens permitidas) e
  `express-rate-limit`, principalmente nas rotas de login e de recuperação de senha.
- Logger estruturado com **pino**.

## Alternativas consideradas

- **NestJS:** traz módulos, injeção de dependência e decorators prontos, mas tem uma
  curva de aprendizado alta e esconde conceitos que a equipe quer entender e aplicar
  manualmente (SOLID, injeção de dependência).
- **Fastify:** é mais rápido, mas o C4 já define Express, e o Express tem mais
  material de estudo disponível.
- **JavaScript sem tipos:** descartado, porque aumenta os erros em tempo de execução
  num código compartilhado.

## Consequências

- Precisa de etapa de build (`tsc`). Em desenvolvimento, usar `tsx watch`.
- A injeção de dependência é feita manualmente (ver ADR-004, arquivo `.module.ts`).
