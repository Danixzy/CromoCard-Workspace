# ADR-027 — Escopo do Marketplace no MVP (decisão em aberto)

- **Status:** Proposto (decisão ainda não tomada pela equipe; bloqueio explícito para a banca)
- **Data:** 2026-09-29
- **Decisores:** Equipe CromoCard

> Este ADR é diferente dos demais: não documenta uma escolha já implícita nos diagramas, e sim
> uma **inconsistência não resolvida** entre os artefatos, que precisa virar decisão formal do PO.

## Contexto

`Apresentacao-Banca/plano-apresentacao-banca.md` (item 8 da seção "Inconsistências encontradas")
identifica o seguinte conflito:

- As user stories do Marketplace **comprador** (compra, anúncios, pedidos, avaliações) estão
  marcadas com `***` (tag `futuro-marketplace`), ou seja, fora do MVP.
- As 10 user stories do **Painel do Vendedor** não têm nenhum marcador, ou seja, estariam no MVP.
- O C4 (Nível 1 e 2) já inclui o Gateway de Pagamento e a Transportadora como sistemas externos
  integrados desde já, sem distinguir MVP de futuro.

Ou seja, os artefatos hoje descrevem cenários incompatíveis entre si sobre se o marketplace faz
parte da primeira entrega.

## Decisão

**Ainda não definida.** Proposta a validar com o PO, como ponto de partida da discussão:

- Tratar o Marketplace (fluxo de **compra**: anúncio → proposta → pedido → pagamento → entrega)
  como pós-MVP (tag `futuro-marketplace`), consistente com a maioria das user stories já
  marcadas `***`.
- Decidir explicitamente o destino do **Painel do Vendedor** (hoje sem marcador): ou recebe a
  mesma tag `futuro-marketplace`, ou é tratado como exceção dentro do MVP (ex.: cadastro de
  anúncio sem o fluxo de pagamento completo).

## Alternativas consideradas

1. **Marketplace completo (compra + venda) no MVP.**
2. **Marketplace inteiramente fora do MVP**, incluindo o Painel do Vendedor.
3. **Painel do Vendedor no MVP, fluxo de compra/pagamento pós-MVP** (proposta acima).

## Consequências

Esta decisão impacta diretamente:

- **ADR-024** (gateway de pagamento) e **ADR-025** (transportadora) — se ficarem fora do MVP,
  essas integrações não precisam estar prontas na primeira entrega.
- O cronograma de sprints e o corte de escopo do board no Azure DevOps.
- Os slides 9, 12 e 16 da apresentação de banca (`Apresentacao-Banca/`), hoje marcados como
  pendentes exatamente por causa desta indefinição.

## Referências

- `Apresentacao-Banca/plano-apresentacao-banca.md` (seção 3, item 8, e checklist da seção 4)
- `docs/Casos-De-Uso/user-stories.md` (legenda de fases: `mvp`, `futuro`, `futuro-marketplace`)
- `docs/Diagramas/Diagramas-C4/01-contexto.puml` e `02-containers.puml`
