# ADR-0008: Integração com gateway de pagamento externo via HTTPS/Webhook

## Status

**Pendente** — identificado em 29/09/2026, aguardando validação do PO.

## Contexto

O Diagrama de Contexto e o de Containers definem um sistema externo "Gateway de Pagamento
(ex.: Stripe/Mercado Pago)" que "processa pagamentos de compras no marketplace e assinaturas do
plano PRO" via HTTPS/Webhook. No C4 Nível 3, o Módulo de Pagamentos e Pedidos integra com esse
gateway. O DER prevê `metodo_pagamento` (`CARTAO_CREDITO`, `PIX`, `BOLETO`) e a entidade
`pagamento`.

## Decisão

Terceirizar todo o processamento de pagamento (cartão, PIX, boleto) a um gateway de pagamento
externo, recebendo confirmações via webhook, sem armazenar dados sensíveis de cartão no banco
próprio.

## Alternativas consideradas

- **Processar pagamentos diretamente** com uma adquirente/PSP próprio, exigindo certificação
  PCI-DSS interna.
- **Múltiplos gateways** simultâneos (ex.: Stripe para cartão internacional + Mercado Pago/PIX
  nacional) com camada de abstração própria.

## Consequências

**Positivas**
- Reduz drasticamente o escopo de compliance PCI-DSS (o gateway custodia os dados de cartão).
- Tempo de implementação menor, aproveitando SDKs prontos.

**Negativas / riscos**
- Dependência de disponibilidade e custos (taxas por transação) do gateway escolhido.
- É necessário tratar webhooks de forma idempotente e validar a assinatura de origem
  (segurança), o que ainda não está detalhado em nenhum artefato.
- O gateway específico não foi definitivamente escolhido (documentação cita "Stripe/Mercado
  Pago" como exemplo, não como decisão fechada) — esta ADR também serve para formalizar essa
  escolha junto ao PO.

## Referências

- `docs/Diagramas/Diagramas-C4/01-contexto.puml`
- `docs/Diagramas/Diagramas-C4/02-containers.puml`
- `docs/Diagramas/Diagramas-C4/03-componentes.puml`
- `docs/Diagramas/DER/README.md` (módulo 6 — Marketplace)
