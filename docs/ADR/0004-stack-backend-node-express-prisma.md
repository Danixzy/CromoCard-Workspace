# ADR-0004: Stack de backend: Node.js + Express + Prisma

## Status

**Pendente** — identificado em 29/09/2026, aguardando validação do PO.

## Contexto

A **API de Aplicação** é definida no C4 (Níveis 2 e 3) como Node.js + Express + Prisma, expondo
REST para as regras de negócio (catálogo, coleção, grupos, chat, perfil, pagamentos e
administração) e autenticando via JWT. O backend é organizado em 9 módulos/componentes
(Autenticação, Acesso Público, Coleção, Comunidade, Chat Pessoal, Perfil, Notificações e
Favoritos, Pagamentos e Pedidos, Administração) — ver
`docs/Diagramas/Diagramas-C4/03-componentes.puml`.

## Decisão

Usar Node.js com Express como framework HTTP da API REST, e Prisma como ORM de acesso ao
PostgreSQL, com o schema Prisma refletindo o DER (nomes em português/`snake_case` via
`@@map`/`@map`).

## Alternativas consideradas

- **NestJS** — framework Node mais opinativo/estruturado (módulos, DI nativa), reduziria a
  necessidade de convenções manuais para organizar os 9 componentes do C4.
- **Django (Python)** ou **Spring Boot (Java)** — stacks com ORM e estrutura de projeto mais
  "batteries included".
- **TypeORM** ou **Sequelize** no lugar do Prisma como ORM.

## Consequências

**Positivas**
- Produtividade alta: Prisma gera cliente tipado e migrations automáticas a partir do schema.
- Toda a equipe já trabalha com JavaScript/TypeScript no frontend, reduzindo troca de contexto.

**Negativas / riscos**
- Express é minimalista: a organização em módulos (Autenticação, Coleção, etc.) depende de
  convenção própria da equipe, sem imposição do framework.
- Prisma tem limitações em queries muito complexas/relatórios agregados pesados (ex.: dashboard
  gerencial do admin, exportação de relatórios — casos de uso 58 e 63), podendo exigir SQL cru
  pontual.

## Referências

- `docs/Diagramas/Diagramas-C4/02-containers.puml`
- `docs/Diagramas/Diagramas-C4/03-componentes.puml`
- `CLAUDE.md` (seções "Arquitetura" e "Padrões de código")
