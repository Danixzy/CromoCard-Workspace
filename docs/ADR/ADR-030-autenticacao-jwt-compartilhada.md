# ADR-030 — Autenticação via JWT compartilhado entre API REST e serviço de tempo real

- **Status:** Substituído por ADR-005
- **Data:** 2026-09-29
- **Decisores:** Equipe CromoCard

## Contexto

O `CLAUDE.md` e o C4 estabelecem: "Autenticação JWT compartilhada entre API e serviço de tempo
real". A API REST autentica requisições via JWT no header `Authorization: Bearer`; o Serviço de
Mensageria em Tempo Real autentica a conexão WebSocket via o mesmo token, validado pelo Módulo de
Autenticação (`Rel(realtime, compAuth, "Valida token JWT da conexao via")` em
`03-componentes.puml`).

## Decisão

Usar um único esquema de autenticação stateless (JWT) emitido pelo Módulo de Autenticação da API,
validado tanto pelas requisições REST quanto pela conexão WebSocket do serviço de tempo real, sem
estado de sessão compartilhado em banco/cache.

## Alternativas consideradas

- **Sessão com cookie + store compartilhado** (ex.: Redis) entre API e serviço de tempo real.
- **OAuth2/OpenID Connect** com provedor de identidade externo.
- **Tokens opacos** com endpoint de introspecção em vez de JWT autocontido.

## Consequências

**Positivas**
- Stateless: qualquer instância da API ou do serviço de tempo real valida o token sem depender de
  um armazenamento central, facilitando escalabilidade horizontal.
- Um único fluxo de login/token para todos os clientes (Web, Mobile, BackOffice).

**Negativas / riscos**
- Revogação antecipada de um token é difícil (logout forçado, banimento de usuário, exclusão de
  conta) — um JWT válido continua sendo aceito até expirar, a menos que se implemente uma
  blacklist/lista de revogação, o que ainda não está descrito nos artefatos.
- Necessário definir tempo de expiração e estratégia de refresh token, ainda não documentados.

## Referências

- `CLAUDE.md` (seção "Arquitetura (C4)" e "Padrões de código")
- `docs/Diagramas/Diagramas-C4/02-containers.puml`
- `docs/Diagramas/Diagramas-C4/03-componentes.puml`
