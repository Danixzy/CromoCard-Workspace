# CLAUDE.md — CromoCard

Projeto acadêmico (Escola de TI) em equipe: **CromoCard — Sistema de Gestão de Cartas Colecionáveis**.
Plataforma para colecionadores organizarem álbuns e cartas/figurinhas, participarem de grupos
da comunidade, conversarem em tempo real e negociarem cartas num marketplace. Administradores
gerenciam usuários, catálogo e comunidade.

Idioma do projeto: **português (pt-BR)** — responda, documente, nomeie tabelas/colunas e
escreva commits em português.

## Estrutura do repositório

```
ESCOLA-TI/                         (repo de documentação/workspace — branch de trabalho: development, principal: main)
├── docs/
│   ├── ADR/                       0001–00NN-titulo.md + README.md (índice) — decisões de arquitetura, status Pendente/Aceita/Rejeitada/Substituída
│   ├── Casos-De-Uso/              NN-nome-do-caso.md (01–93), user-stories.md, resumo-user-stories.md, CromoCard 1.xlsx
│   ├── Diagrama-de-Classe/        cromocard-diagrama-classes.v2.c4 (LikeC4, atual) + .v1.c4 (histórico) + README.md — 43 classes, 1:1 com o DER
│   └── Diagramas/
│       ├── DER/                   puml/, dbdiagram.io/ (DBML), chartdb/ (DDL PostgreSQL) + README.md
│       ├── Diagramas-C4/          01-contexto, 02-containers, 03-componentes (.puml + .svg)
│       ├── Diagrama-Casos-de-Uso/ cromocard_casos_de_uso.puml (CCD001–CCD046)
│       └── Diagrama-Atividades/   Diagrama_Atividades.c4 (LikeC4, CCD001–CCD066)
├── Azure-Devops/                  organização do board, mapa de artefatos por autor, board-cromocard.html
├── apps/                          (não versionado neste repo — cada app é um repo git próprio)
│   ├── Backend-CromoCard/         github.com/Danixzy/Backend-CromoCard   (ainda vazio: só README)
│   └── CromoCard-Frontend/        github.com/Danixzy/CromoCard-Frontend  (ainda vazio: só README)
├── CromoCardWorks.code-workspace  workspace VS Code (raiz + os 2 apps)
└── .mcp.json                      MCP do Azure DevOps (org/projeto `CromoCard`, PAT via $AZURE_DEVOPS_PAT)
```

Os apps ainda não têm código, então **não há comandos de build/test/lint definidos**. Quando
forem criados, atualize esta seção. Ao executar git dentro de `apps/*`, lembre que são repositórios
independentes do repo raiz.

## Arquitetura (C4 — fonte: `docs/Diagramas/Diagramas-C4/`)

**Atores:** Visitante (não autenticado) · Cliente (colecionador) · Vendedor · Administrador.
No diagrama de casos de uso também existe "Administrador do Grupo" (herda de Cliente).

**Containers:**
| Container | Stack | Uso |
|---|---|---|
| Aplicação Web | React + Vite (SPA) | Visitantes e clientes |
| Aplicativo Mobile | React Native | Mesmas funções da web |
| Painel BackOffice | React + Vite (SPA) | Administradores |
| API de Aplicação | Node.js + Express + Prisma | REST, autenticação JWT (`Authorization: Bearer`) |
| Mensageria em Tempo Real | Node.js + WebSocket | Chat pessoal e de grupo, conexão autenticada via JWT |
| Banco de Dados | PostgreSQL (via Prisma ORM) | Todos os dados |

**Sistemas externos:** Gateway de Pagamento (Stripe/Mercado Pago, HTTPS/Webhook) e Transportadora.

**Componentes da API** (organize o backend por esses módulos):
Autenticação · Acesso Público · Coleção · Comunidade · Chat Pessoal · Perfil ·
Notificações e Favoritos · Pagamentos e Pedidos · Administração.

## Modelo de dados (DER — fonte: `docs/Diagramas/DER/`)

- **Fonte da verdade:** `docs/Diagramas/DER/dbdiagram.io/03-der-completo.dbml`. Os `.sql` em
  `chartdb/` e os `.puml` são derivados dele — **mantenha os três formatos sincronizados** ao
  alterar o modelo (43 tabelas, 76 FKs, 22 enums).
- **Convenções:** tabelas/colunas em `snake_case`, português, singular · PK `id bigint`
  auto-incremento · associativas N:N com PK composta (`usuario_conquista`, `voto_enquete`,
  `participante_conversa`) · enums no topo do DBML em MAIÚSCULAS · FKs em `ALTER TABLE` no fim do SQL.
- **Alvos polimórficos:** `favorito` (coluna `tipo` + `album_id`/`carta_id`/`grupo_id`, exatamente
  um preenchido) e `denuncia` (`tipo_alvo` + `anuncio_id`/`usuario_alvo_id`/`mensagem_grupo_id`).
- `carta.album_id` nulo = carta avulsa (portfólio). `solicitacao_cadastro.dados` é `jsonb`.

**8 módulos:**
| # | Módulo | Entidades |
|---|---|---|
| 1 | Usuários, Perfil e Acesso | usuario, perfil, endereco, token_recuperacao_senha, conquista, usuario_conquista, assinatura |
| 2 | Catálogo Global | categoria (hierárquica), raridade, idioma, estado_conservacao, album, carta, foto_carta, historico_preco |
| 3 | Coleção do Cliente | colecao (1:1 usuário), album_usuario, colecao_carta (status POSSUO/FALTANTE/REPETIDA + quantidade) |
| 4 | Comunidade (Grupos) | grupo, membro_grupo, solicitacao_grupo, mensagem_grupo, enquete, opcao_enquete, voto_enquete |
| 5 | Chat Pessoal | conversa, participante_conversa, mensagem, bloqueio_usuario |
| 6 | Marketplace | anuncio, foto_anuncio, proposta, pedido, pagamento, avaliacao |
| 7 | Notificações e Favoritos | favorito, alerta_preco, notificacao, notificacao_global |
| 8 | Moderação e Administração | denuncia, solicitacao_cadastro, log_auditoria, configuracao_global |

Enums principais: `tipo_usuario` (CLIENTE, VENDEDOR, ADMINISTRADOR) · `status_anuncio` (ATIVO,
PAUSADO, ENCERRADO, EXCLUIDO) · `status_pedido` (AGUARDANDO_PAGAMENTO, PAGO, ENVIADO, ENTREGUE,
CANCELADO) · `metodo_pagamento` (CARTAO_CREDITO, PIX, BOLETO). Veja o DBML para os demais.

A tabela de rastreabilidade entidade → caso de uso está em `docs/Diagramas/DER/README.md`.

## Requisitos: casos de uso e user stories

- Código dos casos de uso: **`CCDnnn`** (CCD001…). Arquivos em `docs/Casos-De-Uso/NN-nome.md`.
- Formato de cada caso de uso (tabelas Markdown): Nome · Finalidade/Objetivo · Atores ·
  Pré-condições · **Fluxo Principal** (Ações do Ator | Ações do Sistema) · **Fluxo Alternativo**.
  Siga esse formato ao criar novos.
- User stories: `docs/Casos-De-Uso/user-stories.md` — narrativa "Como <ator> preciso/quero … para …".
- **Escopo / fases** (legenda das user stories):
  - sem marcador → **MVP** (tag `mvp`)
  - `**` → **Futuro** (tag `futuro`) — ex.: escanear carta, alertas de preço, plano PRO, acessibilidade avançada
  - `***` → **Futuro Marketplace** (tag `futuro-marketplace`) — compra, anúncios, pedidos, avaliações
  Priorize o MVP ao implementar; entidades de funcionalidades futuras já existem no DER.
- Áreas funcionais: 1 Painel Público · 2 Painel Cliente · 3 Minha Coleção · 4 Grupos · 5 Chat
  Pessoal · 6 Perfil e Configurações · 7 Notificações e Favoritos · 8 BackOffice · 9 Painel Vendedor.

### Inconsistências conhecidas na documentação (não "corrigir" sem confirmar com o usuário)
- `10-buscar-album.md` tem título "Buscar Álbum", mas o conteúdo é **Solicitar Álbum** (CCD010).
- `80-visualizar-quantidade-disponivel.md` tem título duplicado; o conteúdo é **Visualizar Dados do Vendedor**.
- Busca por vendedor aparece em `33-` e em `67-`.
- CCD032/CCD033 divergem entre o board do Azure e a planilha `CromoCard 1.xlsx`.
- O diagrama de casos de uso (`.puml`) cobre só CCD001–CCD046; o de atividades vai até CCD066;
  os arquivos `.md` vão até 93 (marketplace e painel do vendedor).

## Azure DevOps (board da disciplina)

- Org/projeto `CromoCard`, time `CromoCard Team`. Acesso via MCP `azure-devops` (`.mcp.json`).
- **Nunca altere work items no Azure sem pedido explícito** — os docs em `Azure-Devops/` são leituras/propostas.
- Hierarquia desejada: Epic (produto ou processo) → Feature (área funcional) → User Story
  (`CCD0xx - Verbo + objeto`) → Task (ação técnica, ex.: `Criar endpoint GET /albuns`).
- `#84 Documentacao - CromoCard` é o épico de **processo** (sprints, cerimônias, diagramas); o
  produto deveria ter épico próprio.
- Cerimônias: `<Evento> Sprint NN` (ex.: `Planning Sprint 04`), Daily `Daily DD/MM`,
  apontamentos `Apontamento <Nome>` como Task filha da cerimônia, sempre dentro de `#89 Reuniões`.
- Tipos customizados existentes: Reuniões, Cerimônias, Daily, Spike, Task Spike — não criar novos.
- Equipe: Daniel Andrade (usuário), Felipe Consulim, Lucas Oliveira Lima, Felipe Broetto Araujo,
  Gabriel Nascimento, Lucca Rocha.

## Diagramas — dicas práticas

- PlantUML: exporte em **SVG, não PNG** (o servidor público corta PNG em 4096px).
- Diagramas DER 02 e 03 usam `left to right direction` — mantenha.
- Nas legendas `.puml`, escreva `|` como `&#124;`.
- C4 usa `!include` do C4-PlantUML via GitHub raw.

## Padrões de código (quando os apps começarem)

- Seguir Clean Code, SOLID, Object Calisthenics e design patterns adequados — é o critério usado
  nos code reviews do projeto (skill `code-review-daniel`).
- Backend: Express + Prisma, organizado pelos módulos da API acima; schema Prisma deve refletir o
  DER (nomes em português/snake_case via `@@map`/`@map` se os modelos usarem PascalCase).
- Autenticação JWT compartilhada entre API e serviço de tempo real.
- Ações administrativas devem gerar registro em `log_auditoria`.

## Git

- Branch de trabalho: `development`; PRs para `main`.
- Commits em português, padrão Conventional Commits (`docs: ...`, `feat: ...`) — guia completo
  (tipos, escopo, exemplos, PRs) em `CONTRIBUTING.md`.
