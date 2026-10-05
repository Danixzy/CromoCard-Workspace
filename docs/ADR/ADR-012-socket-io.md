# ADR-012 — Biblioteca de tempo real: Socket.IO

- **Status:** Aceito
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard
- **Complementa:** ADR-007 (define a biblioteca que ficou pendente lá)

## Contexto

O ADR-007 decidiu que o WebSocket fica no mesmo repositório do backend. Falta
escolher a biblioteca. As necessidades do CromoCard são:

- **chat de grupo** (CCD044): enviar uma mensagem para todos os membros de um grupo;
- **chat pessoal** (CCD045–047): conversa entre duas pessoas, com status de leitura (futuro);
- **notificações em tempo real** (CCD053): avisar o usuário, em qualquer tela, de uma
  mensagem, convite ou pedido novo;
- clientes **web (React)** e **mobile (React Native)**, com o mobile perdendo e
  recuperando conexão o tempo todo;
- autenticação com o mesmo JWT da API (ADR-005).

## Opções avaliadas

### Socket.IO
| Prós | Contras |
|---|---|
| **Rooms** nativas: `socket.join('group:42')` e `io.to('group:42').emit(...)`. Cada grupo e cada conversa vira uma room | Protocolo próprio: o cliente **precisa** usar `socket.io-client`, e um WebSocket "puro" não conecta |
| **Reconexão automática** com backoff, essencial no mobile | Um pouco mais de overhead por mensagem que o `ws` |
| **Acks** (confirmação de entrega): o servidor responde "mensagem salva, id 123", útil para o ✓ do chat | Mais uma dependência grande no front e no back |
| Heartbeat embutido, que detecta conexões mortas | Para escalar em várias instâncias precisa do adapter Redis (o `ws` também precisaria de algo equivalente) |
| Middleware de autenticação no handshake (`io.use(...)`) para validar o JWT | |
| Clientes oficiais para React e React Native, com muita documentação | |
| Fallback para HTTP long-polling em redes que bloqueiam WebSocket | |
| **Namespaces** para separar contextos (`/chat`, `/notifications`) | |

### `ws` (WebSocket puro)
| Prós | Contras |
|---|---|
| Leve e muito rápido | Sem rooms: é preciso manter na mão um mapa de "grupo → sockets" |
| Protocolo padrão: qualquer cliente WebSocket conecta, inclusive o nativo do navegador | Sem reconexão: o front precisa implementar |
| Menos "mágica" e fácil de entender | Sem acks nem heartbeat: seria preciso escrever um protocolo próprio de mensagens |
| | Mais código de infraestrutura para a equipe escrever e testar |

### Outras (descartadas)
- **Server-Sent Events (SSE):** a comunicação é só servidor → cliente, e o chat precisa dos dois sentidos.
- **Serviços gerenciados (Pusher, Ably, Firebase):** resolvem tudo, mas são pagos
  acima do plano gratuito, e as regras de bloqueio e de grupo ficariam fora do backend.

## Decisão

Usar **Socket.IO** (`socket.io` no backend, `socket.io-client` no web e no mobile).

Convenções:
- **Autenticação:** o cliente envia o access token em `auth: { token }`, e um
  middleware `io.use` valida esse token pelo módulo de auth. Um token inválido é recusado no handshake.
- **Rooms:** `user:<id>` (notificações pessoais, entrada automática ao conectar),
  `group:<id>` (entrada só se for membro) e `conversation:<id>` (entrada só se for participante).
- **Eventos** em `dominio:acao`: `group-message:send`, `group-message:new`,
  `message:send`, `message:read`, `notification:new`.
- **Persistência primeiro:** o handler chama a service (que valida o bloqueio e a
  participação e grava no banco), e só depois emite para a room. Se a gravação
  falhar, nada é emitido e o ack devolve o erro.
- O payload recebido é validado com o mesmo validator Zod do domínio.

## Consequências

- Menos código de infraestrutura. A equipe foca nas regras do chat.
- O front e o mobile precisam usar `socket.io-client` (com a mesma versão major do servidor).
- Para mais de uma instância em produção, adicionar `@socket.io/redis-adapter`.
