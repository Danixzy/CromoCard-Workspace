# Governança, papéis e acessos — CromoCard

Este documento define **quem faz o quê** e **quem tem qual acesso** no Azure DevOps e no GitHub.
O **como** (branch, commit, PR, passo a passo) está no [`CONTRIBUTING.md`](../../CONTRIBUTING.md).
O **porquê** está no [ADR-0018](../ADR/0018-estrategia-versionamento-rastreabilidade-azure-github.md).

| Documento | Responde |
|---|---|
| ADR-0018 | Por que trabalhamos assim, e o que foi descartado |
| Este documento | Quem pode o quê, como configurar, como auditar, como entrar no time |
| `CONTRIBUTING.md` | Como entregar uma Task, passo a passo |

---

## 1. Papéis

| Papel | Quem | Responsabilidades |
|---|---|---|
| **Admin** | Daniel Andrade + 1 substituto | Configura repositórios, proteções, integrações e acessos. Não aprova os próprios PRs. Único que mexe nas configurações da seção 4 |
| **PO da sprint** | Rotativo, definido na Planning (Sprint 04: Lucas Lima) | Prioriza o backlog, revisa e aprova PRs de arquitetura/documentação, valida regra de negócio, abre os PRs de fim de sprint e cria a tag de versão |
| **Responsável de frente** | 1 por frente: Arquitetura, Backend, Frontend, Infraestrutura | Revisor padrão dos PRs de código da frente, quebra User Stories em Tasks, mantém os escopos de commit e o README do repositório |
| **Dev** | Todo o time | Pega Tasks, abre branch e PR, revisa PRs de colegas da mesma frente |

- Uma pessoa pode ter mais de um papel (ex.: Dev + Responsável de frente). O que nunca acontece é
  alguém **aprovar o próprio PR**.
- **Substituto do admin:** com um único admin, se o Daniel ficar indisponível ninguém consegue
  mudar acesso nem proteção. Definir o segundo admin é o item 1 da seção 4.
- Quem é responsável de cada frente e quem é PO de cada sprint fica registrado na tabela da seção 2
  e é atualizado **por PR**, como qualquer outra mudança.

### Matriz de responsabilidade (RACI)

R = executa · A = aprova/responde pelo resultado · C = consultado · I = informado

| Atividade | Dev | Resp. de frente | PO da sprint | Admin |
|---|---|---|---|---|
| Criar User Story / priorizar backlog | C | C | **A/R** | I |
| Quebrar User Story em Tasks | C | **R** | **A** | — |
| Desenvolver a Task (branch, commits, PR) | **R** | C | I | — |
| Revisar PR de código | R (par) | **A** | C (regra de negócio) | — |
| Revisar PR de arquitetura/documentação | R (autor) | C | **A** | — |
| Promover `development → homolog → main` | — | C | **A/R** | I |
| Criar tag e Release da sprint | — | — | **R** | I |
| Configurar acessos, proteções, integrações | — | I | C | **A/R** |
| Criar ADR nova | **R** | C | **A** | I |

---

## 2. Time e contas

> Atualize esta tabela por PR sempre que alguém entrar, sair ou mudar de papel. A coluna GitHub é o
> que o admin usa para dar acesso; confirme o seu usuário.

| Pessoa | GitHub | Frente principal | Papel além de Dev |
|---|---|---|---|
| Daniel Andrade | `Danixzy` | _a definir_ | Admin |
| Lucas Oliveira Lima | `justAnormlaguy` | _a definir_ | PO da Sprint 04 |
| Lucca Rocha | `Lucskrr` | _a definir_ | — |
| Felipe Consulim | _confirmar_ (`Feliped15`?) | _a definir_ | — |
| Felipe Broetto Araujo | _confirmar_ | _a definir_ | — |
| Gabriel Nascimento | _confirmar_ (`Biel-developer`?) | _a definir_ | — |

**Responsáveis de frente:** Arquitetura `_a definir_` · Backend `_a definir_` ·
Frontend `_a definir_` · Infraestrutura `_a definir_`.

---

## 3. Acessos

### 3.1 Como está hoje (levantamento de 02/10/2026)

| Repositório | Dono | Visível | Colaboradores com escrita | Proteção de branch |
|---|---|---|---|---|
| `CromoCard-Workspace` | conta pessoal `Danixzy` | Pública | `Danixzy` (admin), `justAnormlaguy`, `Lucskrr`, `Feliped15` | **Nenhuma** |
| `Backend-CromoCard` | conta pessoal `Danixzy` | Pública | não foi possível listar (`Lucskrr` só tem leitura) | **Nenhuma** |
| `CromoCard-Frontend` | conta pessoal `Danixzy` | Pública | `Danixzy` (admin), `justAnormlaguy`, `Lucskrr`, `Feliped15`, `Biel-developer` | **Nenhuma** |

Problemas encontrados:

1. **Sem proteção de branch:** qualquer colaborador consegue dar push direto em `main`,
   `homolog` e `development`, inclusive force push. As regras do `CONTRIBUTING.md` hoje dependem
   só de disciplina.
2. **Acessos diferentes em cada repositório:** o time tem 6 pessoas, mas o Workspace tem 4
   colaboradores e o Frontend tem 5. No Backend, pelo menos uma pessoa do time só tem leitura.
3. **Conta pessoal, não organização:** em repositório de conta pessoal o GitHub só tem dois níveis,
   dono e colaborador. Não existem times, papéis intermediários nem revisão automática por time.
   Um só admin significa um só ponto de falha.
4. **Issues ativadas no GitHub:** abre espaço para um segundo backlog fora do Azure (a revisão das
   ADRs foi parar na issue #1).

### 3.2 Como deve ficar

**Recomendação: mover os repositórios para uma Organização do GitHub** (gratuita para repositórios
públicos), por exemplo `cromocard`. Transferir um repositório preserva histórico, PRs, branches e
redireciona as URLs antigas.

Na organização:

| Time do GitHub | Membros | Acesso |
|---|---|---|
| `@cromocard/arquitetura` | quem atua em arquitetura | Write nos 3 repositórios |
| `@cromocard/backend` | devs de backend | Write nos 3 repositórios |
| `@cromocard/frontend` | devs de frontend | Write nos 3 repositórios |
| `@cromocard/infra` | devs de infraestrutura | Write nos 3 repositórios |
| `@cromocard/po` | **só o PO da sprint atual** (troca a cada Planning) | Write nos 3 repositórios |
| Owners da organização | Daniel + substituto | Admin |

- **Todo mundo tem Write em todos os repositórios.** Qualquer pessoa pode abrir branch e PR em
  qualquer repo (ex.: um dev de backend corrige um ADR). Quem controla o que entra é a
  **revisão obrigatória**, não o acesso.
- O arquivo **`.github/CODEOWNERS`** de cada repositório aponta o time revisor por pasta, e o GitHub
  pede a revisão automaticamente. Exemplo para o Workspace:

  ```
  # Revisor padrão: PO da sprint
  *                         @cromocard/po
  /docs/ADR/                @cromocard/po @cromocard/arquitetura
  /docs/Diagramas/          @cromocard/arquitetura
  /.github/                 @cromocard/infra
  ```

  Exemplo para o Backend:

  ```
  *                         @cromocard/backend
  /prisma/                  @cromocard/backend @cromocard/arquitetura
  /.github/                 @cromocard/infra
  /Dockerfile               @cromocard/infra
  ```

- Como o PO muda a cada sprint, basta trocar o membro do time `@cromocard/po`. O `CODEOWNERS` não
  muda.

**Se a organização não for criada**, o mínimo é: os 6 com Write nos 3 repositórios, proteção de
branch ativa (seção 4) e o autor pedindo o revisor manualmente no PR. O `CODEOWNERS` pode usar os
usuários individuais, mas terá de ser editado a cada troca de PO.

**Fluxo de PR sem fork:** como todos têm Write, as branches são criadas **no próprio repositório**
(não em fork). Isso deixa a branch visível para o time e permite que o revisor faça checkout dela.

### 3.3 Azure DevOps

| Grupo no projeto `CromoCard` | Quem | Para quê |
|---|---|---|
| Project Administrators | Admin + substituto | Conectar o GitHub, criar Area/Iteration Paths, gerenciar membros |
| Contributors | Todo o time | Criar e editar work items, mover no board |

- Nível de acesso: o Azure DevOps dá 5 licenças **Basic** gratuitas por organização. A sexta pessoa
  pode ficar como **Stakeholder**, que já permite criar, editar e mover work items no board; confirme
  em *Organization Settings → Users*.
- Ninguém altera tipos de work item nem o processo (ver `CLAUDE.md`).

---

## 4. Configuração — checklist do admin

Faça na ordem. Marque aqui por PR quando concluir, para ficar registrado.

**GitHub — organização e acessos**
- [ ] 1. Definir o admin substituto.
- [ ] 2. Criar a organização (ou decidir ficar na conta pessoal — registre a decisão no ADR-0018).
- [ ] 3. Transferir os 3 repositórios (*Settings → General → Danger Zone → Transfer*).
- [ ] 4. Criar os times da seção 3.2 e dar Write a eles nos 3 repositórios.
- [ ] 5. Conferir que as 6 pessoas da seção 2 têm Write nos 3 repositórios.

**GitHub — em cada repositório**
- [ ] 6. *Settings → General*: branch padrão = `development`.
- [ ] 7. *Settings → General → Pull Requests*: deixar marcados só **Allow squash merging** (com a
      mensagem padrão "Pull request title and description") e **Allow merge commits**; desmarcar rebase; marcar
      **Automatically delete head branches**.
- [ ] 8. *Settings → General → Features*: desmarcar **Issues** e **Wiki** (o backlog é o Azure e a
      documentação é o Workspace).
- [ ] 9. *Settings → Rules → Rulesets → New branch ruleset*, alvo `development`, `homolog`, `main`:
  - Restrict deletions
  - Block force pushes
  - Require a pull request before merging → 1 approval · Dismiss stale approvals ·
    Require review from Code Owners · Require conversation resolution
  - Require status checks to pass (quando existir CI — item 13)
  - Bypass list: **vazia** (nem o admin pula a revisão)
- [ ] 10. Workspace: criar a branch `main` a partir de `development`.
- [ ] 11. Adicionar `.github/pull_request_template.md` e `.github/CODEOWNERS` nos 3 repositórios
      (uma Task por repositório).

**Integração Azure ↔ GitHub**
- [ ] 12. Instalar o app **Azure Boards** (github.com/marketplace/azure-boards) na organização /
      conta, dando acesso aos 3 repositórios, e em *Azure → Project Settings → GitHub connections*
      conectar os 3.
- [ ] 13. Criar Task de infra para o CI mínimo em cada repo: validar o título do PR no formato
      Conventional Commits (o título vira o commit no squash) e, nos apps, `lint`, `typecheck` e
      `test`. Depois, marcar esses checks como obrigatórios no item 9.
- [ ] 14. Azure: criar as Area Paths `Arquitetura`, `Backend`, `Frontend`, `Infraestrutura`.

**Limpeza**
- [ ] 15. Apagar branches antigas sem PR (ex.: `Documento-referente-Daily-25/09` no Workspace),
      depois de confirmar com o autor que não há nada a aproveitar.

---

## 5. Auditoria — como provar quem fez, revisou e entregou

A cadeia de evidências de qualquer entrega:

```
Task #319 (Azure: histórico de estado, responsável, sprint)
   └─► branch docs/319-...          (nome traz o ID)
        └─► commits "... AB#319"    (autor e data)
             └─► PR #12             (descrição, Fixes AB#319, revisões, aprovador, checks, discussão)
                  └─► squash commit em development  (link para o PR)
                       └─► PR "chore(release): Sprint 04" → main
                            └─► tag v0.4.0 + GitHub Release (lista de Tasks da sprint)
```

| Pergunta | Onde responder |
|---|---|
| O que foi entregue na Task X? | Azure → Task X → seção **Development** (links de commits e PR) |
| Quem aprovou a mudança Y? | PR → aba **Conversation** / **Files changed** (reviews) |
| O que mudou na Sprint NN? | GitHub → **Releases** → `v0.NN.0` |
| Quando e por quem um arquivo mudou? | `git log --follow <arquivo>` ou *History* no GitHub |
| Por que uma decisão de arquitetura foi tomada? | `docs/ADR/` |
| Alguém mudou acesso ou proteção? | Organização → *Settings → Audit log* (só existe em organização) |

**Regras que mantêm a cadeia íntegra**
- Nada entra nas branches permanentes sem PR, e nenhum PR entra sem aprovação.
- Nunca reescrever histórico das branches permanentes (`force push` bloqueado).
- Nunca apagar PR, review ou comentário. Mudou de ideia? Comente explicando.
- Toda Task fechada tem pelo menos um PR vinculado, ou um comentário explicando por que não
  precisou de código (ex.: reunião, pesquisa).

---

## 6. Entrada de uma pessoa nova (onboarding)

Para quem chega, em ordem:

1. Envie seu usuário do GitHub e e-mail ao admin.
2. Admin: adiciona no Azure DevOps (Contributors) e no time certo do GitHub. Atualiza a tabela da
   seção 2 **por PR**.
3. Configure o Git com o seu nome real e o e-mail da conta do GitHub:
   ```bash
   git config --global user.name "Nome Sobrenome"
   git config --global user.email "email-da-conta-github@exemplo.com"
   ```
4. Clone o Workspace e os apps (ver `CromoCardWorks.code-workspace`):
   ```bash
   git clone https://github.com/Danixzy/CromoCard-Workspace.git
   cd CromoCard-Workspace
   git clone https://github.com/Danixzy/Backend-CromoCard.git  apps/Backend-CromoCard
   git clone https://github.com/Danixzy/CromoCard-Frontend.git apps/CromoCard-Frontend
   ```
   (troque `Danixzy` pela organização, se os repositórios forem transferidos)
5. Leia, nesta ordem: `CONTRIBUTING.md` → este documento → ADR-0018 → `CLAUDE.md`.
6. Primeira entrega: uma Task pequena seguindo o `CONTRIBUTING.md` do início ao fim.

**Saída de alguém:** o admin remove do time do GitHub e do Azure, reatribui as Tasks abertas e
atualiza a seção 2 por PR. Os commits e reviews da pessoa continuam no histórico.
