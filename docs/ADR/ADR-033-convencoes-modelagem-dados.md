# ADR-033 — Convenções de modelagem de dados (nomenclatura, PK, associativas N:N)

- **Status:** Substituído por ADR-003 e ADR-014
- **Data:** 2026-09-29
- **Decisores:** Equipe CromoCard

## Contexto

O DER (`docs/Diagramas/DER/README.md`, seção "Convenções") estabelece um conjunto de regras
aplicadas a todo o schema (43 tabelas, 76 FKs, 22 enums):

- Nomes de tabelas/colunas em `snake_case`, **português**, singular.
- `id bigint` auto-incremento como PK em todas as entidades fortes.
- Entidades associativas N:N usam **PK composta** (`usuario_conquista`, `voto_enquete`,
  `participante_conversa`), sem `id` substituto.
- Enums centralizados no topo dos arquivos `.dbml`, em maiúsculas.

## Decisão

Adotar essas quatro convenções como padrão obrigatório para todo o modelo de dados do CromoCard,
mantidas sincronizadas nos três formatos derivados (`.dbml`, `.sql`, `.puml` — ver
`docs/Diagramas/DER/README.md`).

## Alternativas consideradas

- **Nomenclatura em inglês** (comum em times que usam bibliotecas/ferramentas internacionais).
- **UUID** como tipo de chave primária, em vez de `bigint` sequencial.
- **PK substituta própria** (`id`) mesmo em tabelas puramente associativas N:N.

## Consequências

**Positivas**
- Consistência com o domínio de negócio: equipe, PO e banca falam português — reduz tradução
  mental entre requisito e schema.
- Simplicidade de leitura do schema e das migrations geradas pelo Prisma.

**Negativas / riscos**
- `bigint` sequencial expõe volume e ordem de criação dos registros (IDs previsíveis) — relevante
  em endpoints públicos que expõem IDs (ex.: anúncio, perfil), podendo facilitar enumeração por
  terceiros.
- Divergência do padrão em inglês usado por boa parte do ecossistema Node/Prisma (documentação,
  exemplos de bibliotecas), exigindo atenção redobrada ao usar `@@map`/`@map`.

## Referências

- `docs/Diagramas/DER/README.md` (seção "Convenções")
- `CLAUDE.md` (seção "Modelo de dados")
