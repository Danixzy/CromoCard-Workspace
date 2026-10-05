# ADR-016 — Colunas de tempo: `created_at`, `updated_at`, `deleted_at` em todas as tabelas e `timestamptz`

- **Status:** Aceito
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard
- **Amplia:** ADR-015 (o `deleted_at` deixa de ser só das tabelas com ação de exclusão e passa a existir em todas)

## Contexto

1. Todas as datas do DER eram `timestamp` **sem fuso horário**. O ADR-011 define que a
   API trabalha em UTC, mas um `timestamp` sem fuso guarda a hora "como veio". Se o
   servidor, o banco ou a conexão estiverem em fusos diferentes (ex.: servidor em UTC,
   máquina do desenvolvedor em `America/Sao_Paulo`), os horários mudam sem erro nenhum.
2. Só algumas tabelas tinham `updated_at`, e várias tinham a data de criação com nomes
   diferentes (`sent_at`, `joined_at`, `added_at`, `earned_at`, `requested_at`,
   `voted_at`, `blocked_at`, `user_albums.start_date`).

## Decisão

1. **Toda data com hora é `timestamptz`** (`timestamp with time zone`). O PostgreSQL
   guarda em UTC e converte na leitura. Datas sem hora (`subscriptions.start_date`,
   `price_history.reference_date`) continuam `date`.
2. **Toda tabela tem as três colunas**, sempre as últimas e nesta ordem:
   | Coluna | Tipo | Regra |
   |---|---|---|
   | `created_at` | `timestamptz NOT NULL DEFAULT now()` | Preenchida na criação e nunca alterada |
   | `updated_at` | `timestamptz NOT NULL DEFAULT now()` | Atualizada a cada alteração (Prisma `@updatedAt`) |
   | `deleted_at` | `timestamptz NULL` | Soft delete (ADR-015); nulo = ativo |
3. **Colunas que eram a data de criação com outro nome foram renomeadas para `created_at`**,
   para não haver duas colunas com a mesma informação: `sent_at`, `joined_at`,
   `added_at`, `earned_at`, `requested_at`, `voted_at`, `blocked_at` e `user_albums.start_date`.
   Datas com outro significado continuam com nome próprio: `expires_at`, `revoked_at`,
   `read_at`, `closes_at`, `reviewed_at`, `resolved_at`, `muted_until`.
4. No Prisma:
   ```prisma
   createdAt DateTime  @default(now()) @map("created_at") @db.Timestamptz
   updatedAt DateTime  @updatedAt       @map("updated_at") @db.Timestamptz
   deletedAt DateTime?                  @map("deleted_at") @db.Timestamptz
   ```
   O `@updatedAt` é aplicado pelo Prisma, não pelo banco. Um `UPDATE` em SQL puro
   (seed, script) precisa preencher `updated_at` manualmente.

## Alternativas consideradas

- **Manter `timestamp` e "tomar cuidado":** depende de todo mundo lembrar do fuso, sempre.
- **Trigger no banco para `updated_at`:** funciona também para SQL puro, mas espalha
  lógica entre o banco e o Prisma. Pode ser adicionado depois, se for preciso.
- **Colunas de tempo só onde "faz sentido":** gera a pergunta "essa tabela tem ou não
  tem?" a cada query. Uma regra uniforme é mais simples.

## Consequências

- Uniformidade: todo model do Prisma termina com as mesmas três linhas.
- Tabelas que nunca são excluídas (histórico, `audit_logs`) têm `deleted_at` sempre
  nulo. É um custo mínimo em troca da regra única.
- A exceção do ADR-015 continua valendo: tokens expirados são removidos fisicamente pelo cron.
- DER atualizado nos 8 arquivos. Também foi corrigida a coluna `user_albums.favorites`
  → `is_favorite` (erro da tradução, que tinha usado o nome da tabela `favorites`).
