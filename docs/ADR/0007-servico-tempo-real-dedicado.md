# ADR-0007: Serviço de mensageria em tempo real como container dedicado

## Status

**Pendente** — identificado em 29/09/2026, aguardando validação do PO.

## Contexto

O C4 Nível 2 separa o **Serviço de Mensageria em Tempo Real** (Node.js + WebSocket) da **API de
Aplicação** (Node.js + Express), como dois containers distintos que acessam o mesmo banco
PostgreSQL via Prisma ORM. O serviço entrega chat pessoal e de grupo em tempo real, com conexão
autenticada via JWT (ver ADR-0006).

## Decisão

Manter o chat (pessoal e de grupo) em um serviço WebSocket separado da API HTTP principal, como
container/deploy independente.

## Alternativas consideradas

- **WebSocket embutido** no mesmo processo/container da API Express (um único deploy).
- **Serviço gerenciado de terceiros** para realtime (ex.: Pusher, Ably, Firebase Realtime
  Database/Firestore) em vez de um serviço próprio.

## Consequências

**Positivas**
- Escalabilidade e deploy independentes: picos de tráfego de chat não competem por recursos com a
  API REST.
- Isolamento de falhas — uma instabilidade no serviço de tempo real não derruba o restante da
  aplicação.

**Negativas / riscos**
- Dois serviços Node.js para manter sincronizados (mesmas regras de autenticação e acesso a
  dados).
- Se houver múltiplas réplicas do serviço de tempo real, é necessária uma estratégia de fan-out
  entre instâncias (ex.: Redis pub/sub) para que mensagens cheguem a todos os clientes conectados
  em réplicas diferentes — não descrita nos diagramas atuais.

## Referências

- `docs/Diagramas/Diagramas-C4/02-containers.puml`
- `docs/Diagramas/Diagramas-C4/03-componentes.puml`
