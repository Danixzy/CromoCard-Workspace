# ADR-007 — Tempo real: WebSocket no mesmo repositório

- **Status:** Aceito (biblioteca definida no ADR-012)
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard

## Contexto

O C4 prevê um container "Serviço de Mensageria em Tempo Real" (Node.js + WebSocket)
para o chat pessoal e o chat de grupo. Ele precisa validar o JWT, checar bloqueios
(`user_blocks`), verificar se o usuário é membro do grupo e gravar as mensagens.
São as mesmas regras dos domínios `chat` e `community`.

## Decisão

- O servidor WebSocket fica **no mesmo repositório** do backend, com um entrypoint
  próprio (`src/realtime.ts`) e o código de transporte em `src/infra/realtime/`.
- Ele **reaproveita as services** dos domínios `auth`, `chat` e `community`. Nenhuma
  regra de negócio é duplicada: o handler do socket só traduz evento ↔ service, como
  um controller.
- Em desenvolvimento, API e WebSocket podem rodar no mesmo processo (o WebSocket
  anexado ao mesmo servidor HTTP). Em produção, podem ser dois processos, o que
  atende o C4 (dois containers com o mesmo código).
- **Biblioteca proposta: Socket.IO.** As *rooms* dele mapeiam direto para os grupos
  e conversas. Ele também traz reconexão automática, confirmação de entrega (*acks*)
  e cliente pronto para React e React Native. A alternativa é o `ws` puro: mais leve,
  mas exige implementar rooms, reconexão e heartbeat na mão.

## Alternativas consideradas

- **Repositório separado para o tempo real:** duplicaria o Prisma, os tipos, a
  validação de JWT e as regras de chat e grupo, ou exigiria um pacote compartilhado.
  É complexidade sem benefício neste momento.
- **Polling HTTP:** atrasa as mensagens e gera carga desnecessária.

## Consequências

- Um só CI, um só `package.json` e o mesmo schema de banco.
- Se houver mais de uma instância do WebSocket, será preciso um adapter (Redis) para
  as rooms funcionarem entre instâncias. Para um projeto acadêmico, basta uma instância.
