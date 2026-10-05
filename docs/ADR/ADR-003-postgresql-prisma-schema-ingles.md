# ADR-003 — Banco: PostgreSQL + Prisma, pasta `database/`, schema em inglês

- **Status:** Aceito (formato dos IDs substituído pelo ADR-014)
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard

## Contexto

O DER (`docs/Diagramas/DER/`) define 44 tabelas em PostgreSQL. Originalmente os
nomes estavam em português, e o código seria escrito em inglês. Isso obrigaria a
fazer `@map` em praticamente todo campo do Prisma.

## Decisão

1. **PostgreSQL** como banco e **Prisma** como ORM e ferramenta de migrations.
2. **O DER passa a ser em inglês** (tabelas, colunas, enums e valores de enum).
   Comentários e documentação continuam em português. O glossário PT → EN fica em
   `docs/Diagramas/DER/README.md`.
3. **Tabelas no plural** em `snake_case` (`users`, `orders`, `groups`), porque
   `user`, `order` e `group` são palavras reservadas do PostgreSQL. No Prisma, os
   models ficam no singular em PascalCase e são mapeados para a tabela:
   ```prisma
   model User {
     id           BigInt   @id @default(autoincrement())
     passwordHash String?  @map("password_hash")
     createdAt    DateTime @default(now()) @map("created_at")
     @@map("users")
   }
   ```
4. A pasta se chama **`database/`**, e não `prisma/`, para não amarrar o nome da
   pasta ao ORM:
   ```
   database/
   ├── schema.prisma
   ├── migrations/      (gerada pelo `prisma migrate dev`)
   └── seeds/           (raridades, idiomas, estados de conservação, admin inicial)
   ```
   O caminho é configurado em `prisma.config.ts` (campo `schema`).
5. Toda mudança no modelo começa pelo DER (`03-der-completo.dbml`), é refletida no
   `schema.prisma` e gera uma migration versionada. O `prisma db push` nunca é usado
   fora de protótipo local.

## Alternativas consideradas

- **Manter o DER em português e mapear campo a campo no Prisma:** gera centenas de
  `@map` e obriga a traduzir mentalmente o tempo todo.
- **TypeORM / Sequelize:** dão mais trabalho com tipagem, e as migrations são mais frágeis.
- **Knex / SQL puro:** dão mais controle, mas exigem mais código repetitivo, sem ganho para o projeto.

## Consequências

- Os SVGs antigos do DER precisam ser reexportados.
- Os documentos que citam nomes antigos de tabela (casos de uso e rastreabilidade)
  devem ser lidos junto com o glossário.
- Nova tabela `refresh_tokens` adicionada ao DER (ver ADR-005).
