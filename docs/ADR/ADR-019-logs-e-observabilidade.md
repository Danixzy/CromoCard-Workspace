# ADR-019 — Logs e observabilidade

- **Status:** Proposto
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard

## Contexto

Quando algo der errado em homologação ou produção, a equipe precisa descobrir **o que
aconteceu, com qual requisição e com qual usuário**, sem acesso ao debugger. Ao mesmo
tempo, o log não pode vazar dados pessoais nem credenciais (LGPD, segurança).

## Decisão

### Logger
- **pino** (ADR-002), configurado em `src/infra/logger.ts`, e **pino-http** para as requisições.
- **Formato:** JSON em homologação e produção (fácil de buscar e filtrar);
  `pino-pretty` (colorido e legível) no ambiente local.
- `console.log` é proibido (ADR-017). O logger é injetado ou importado de `@/infra/logger`.

### Níveis
| Nível | Quando usar | Exemplo |
|---|---|---|
| `fatal` | A aplicação vai cair | Não conectou no banco no boot |
| `error` | Falha inesperada (`500`), com stack trace | Exceção não tratada, gateway fora do ar |
| `warn` | Algo estranho, mas tratado | Refresh token reutilizado, CEP indisponível (fallback) |
| `info` | Eventos de negócio e ciclo de vida | Servidor iniciou, pedido criado, job executado |
| `debug` | Detalhe para desenvolvimento | Query montada, payload recebido |

`LOG_LEVEL` controla o mínimo: `debug` no ambiente local, `info` em homologação e produção.
Erros `4xx` são esperados (culpa do cliente) e **não** são logados como `error`.

### Rastreamento por requisição (`requestId`)
- Toda requisição recebe um `requestId`: usa o header `X-Request-Id`, se vier, ou gera um UUID.
- O `requestId` aparece **em todas as linhas de log** daquela requisição e volta no
  header de resposta `X-Request-Id`.
- Em respostas `500`, o corpo inclui o `requestId`, para o usuário ou o front reportar:
  `{ "error": "INTERNAL_ERROR", "message": "Erro inesperado", "requestId": "…" }`.
- Cada requisição gera **uma** linha de acesso: método, rota, status, duração em ms, `requestId` e `userId` (se autenticado).

### O que **nunca** vai para o log (redaction do pino)
- Senhas, hashes de senha, tokens (access, refresh, reset), header `Authorization`, cookies.
- Dados pessoais: e-mail, CPF, endereço, telefone. Identifique o usuário pelo **`userId`**.
- Dados de pagamento.

Configurado com `redact` do pino, por exemplo:
`['req.headers.authorization', 'req.headers.cookie', '*.password', '*.token', '*.refreshToken', '*.email']`.

### Saúde da aplicação
- `GET /health` responde `200` se o processo está de pé (*liveness*).
- `GET /health/ready` também checa o banco e responde `503` se ele estiver fora (*readiness*).
- **Encerramento gracioso:** ao receber `SIGTERM`, para de aceitar requisições,
  termina as que estão em andamento, fecha o banco e o Socket.IO, e só então encerra.

### Monitoramento de erros (futuro)
- Quando houver produção real: **Sentry** (plano gratuito), para receber alerta e stack
  trace dos `500` automaticamente. Fica fora do escopo agora.

## Alternativas consideradas

- **winston:** popular, porém mais lento e com mais configuração que o pino.
- **Stack completa de observabilidade (OpenTelemetry, Grafana, Loki):** poderosa, mas
  exagerada para o projeto neste momento. O `requestId` já prepara o terreno para ela.

## Consequências

- Qualquer erro reportado ("deu erro, código abc-123") é encontrado nos logs pelo `requestId`.
- O log não expõe dados pessoais nem credenciais.
- Homologação e produção precisam de um lugar para ler os logs (definido com o deploy).
