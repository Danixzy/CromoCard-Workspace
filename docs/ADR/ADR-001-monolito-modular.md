# ADR-001 — Estilo arquitetural: monólito modular

- **Status:** Aceito
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard

## Contexto

O backend precisa atender 9 áreas de negócio (autenticação, catálogo, coleção,
comunidade, chat, perfil, notificações, marketplace e administração). A equipe tem
6 pessoas, é a primeira arquitetura que a equipe define e o projeto tem prazo de
disciplina.

**Sobre o termo "monólito":** monólito **não** quer dizer "front e back juntos".
Quer dizer que o **backend inteiro é uma única unidade de deploy**: um só código,
um só build e um só banco. O frontend estar em outro repositório não muda isso. O
oposto de monólito são os **microsserviços**, em que cada domínio (ex.: pagamentos,
chat) é uma aplicação separada, com deploy e banco próprios, e os domínios se
comunicam pela rede.

## Decisão

Adotar um **monólito modular**:

- **Um** repositório (`Backend-CromoCard`), **um** banco PostgreSQL e **um** build.
- Código dividido em **módulos por domínio** (`src/domains/<dominio>`), cada um com
  as próprias camadas (ver ADR-004).
- Os módulos só se comunicam pela **service pública** do outro módulo, nunca pelo
  repository ou pelas tabelas do outro módulo.
- Dois processos a partir do mesmo código: API REST e servidor WebSocket (ver ADR-007).
  Continua sendo um monólito, porque os dois compartilham código e banco.

## Alternativas consideradas

- **Monólito em camadas** (`controllers/`, `services/` e `models/` na raiz): é
  simples de começar, mas cada feature fica espalhada por várias pastas e os
  domínios ficam acoplados sem ninguém perceber.
- **Microsserviços:** exigem deploy, rede, observabilidade e consistência entre
  bancos. Esse custo não se paga para 6 pessoas num projeto acadêmico.

## Consequências

- Deploy e desenvolvimento local simples (um `docker compose up`).
- Cada integrante pode ser dono de um domínio com pouco conflito de merge.
- Se um domínio precisar escalar sozinho no futuro (ex.: chat), as fronteiras entre
  módulos já existem, o que facilita extrair um serviço.
- A regra "não acessar o repository de outro domínio" precisa ser cobrada no code review.
