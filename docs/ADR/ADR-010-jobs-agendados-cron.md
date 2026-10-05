# ADR-010 — Jobs agendados com cron

- **Status:** Aceito
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard

## Contexto

Algumas regras dependem da passagem do tempo, e não de uma requisição.

## Decisão

- Usar **`node-cron`**, com os jobs em `src/infra/jobs/`. Cada job chama uma
  **service** de domínio: o job só agenda, a regra fica na service.
- Os jobs rodam em **uma única instância** (flag `JOBS_ENABLED=true` só nela).
- Todo job registra no log o início, o fim, a duração e a quantidade de registros afetados.

Jobs previstos:

| Job | Frequência | Domínio |
|---|---|---|
| Limpar `password_reset_tokens` e `refresh_tokens` expirados (única exclusão física, ver ADR-015) | diário | auth |
| Encerrar `polls` com `closes_at` vencido | a cada 5 min | community |
| Expirar `offers` pendentes após o prazo (`EXPIRED`) | a cada hora | marketplace (futuro) |
| Expirar `subscriptions` vencidas | diário | users (futuro) |
| Snapshot diário de `price_history` | diário | catalog (futuro) |

**Não precisa de cron:** silenciar um grupo (`muted_until` é comparado com `now()`
na hora de notificar) e qualquer regra que possa ser checada no momento da leitura.

## Alternativas consideradas

- **BullMQ + Redis:** tem filas, retry e funciona com várias instâncias. É a evolução
  natural se o sistema escalar ou se precisar de filas (ex.: disparo de notificação
  global em massa).
- **Cron do sistema operacional / agendador da nuvem:** tira os jobs do código e dificulta o desenvolvimento local.

## Consequências

- Simples de rodar localmente.
- Com mais de uma instância, rodar os jobs em todas executaria cada job em duplicidade.
  Por isso existe a flag `JOBS_ENABLED`.
