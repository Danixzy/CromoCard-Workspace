# Guia de Contribuição — CromoCard

Como a equipe **CromoCard Team** transforma uma Task do **Azure DevOps** em entrega no **GitHub**.
Vale para todos os repositórios do projeto e para todas as frentes: arquitetura, backend, frontend
e infraestrutura.

**Objetivo:** toda entrega no GitHub aponta para uma Task do Azure, toda Task do Azure mostra o que
foi entregue, e toda mudança tem alguém que revisou e aprovou — sem ninguém precisar perguntar no
grupo.

| Documento | Responde |
|---|---|
| **Este guia** | **Como** entregar uma Task, passo a passo |
| [`docs/Processo/governanca-e-acessos.md`](docs/Processo/governanca-e-acessos.md) | **Quem** faz o quê, quem tem qual acesso, como auditar, como entrar no time |
| [ADR-0018](docs/ADR/0018-estrategia-versionamento-rastreabilidade-azure-github.md) | **Por que** trabalhamos assim e o que foi descartado |

O modelo é **GitLab Flow com feature branches por work item, Conventional Commits e
rastreabilidade Azure Boards ↔ GitHub** (referências na seção 14).

---

## 1. Regras de ouro

1. **Ninguém commita direto em `development`, `homolog` ou `main`.** Tudo entra por Pull Request.
2. **1 Task do Azure = 1 branch = 1 PR.** Sem Task, sem branch: crie a Task primeiro.
3. **Todo commit e todo PR citam a Task com `AB#<id>`.**
4. **Ninguém aprova o próprio PR.** A revisão acontece no PR, não em Issue, grupo ou reunião.
5. **Uma Task mexe em um repositório só.** Mudança em dois repositórios = duas Tasks.

## 2. Resumo em 1 minuto

```
Azure: pego a Task #319 ─► Active
  │
  ▼
git switch development && git pull
git switch -c docs/319-revisao-adrs           ← 1 Task = 1 branch
  │
  ▼
commits:  docs(adr): ajusta ADR-0001 conforme revisão do PO
          AB#319
  │
  ▼
git push -u origin docs/319-revisao-adrs
PR  docs/319-revisao-adrs ─► development       ← "Fixes AB#319" na descrição
  │
  ▼
Revisor comenta no PR ─► ajusto na mesma branch ─► revisor aprova
  │
  ▼
Squash and merge ─► branch apagada ─► Task vai para Closed sozinha
```

---

## 3. Mapa: frentes, repositórios e revisores

| Frente | Repositório | O que entra | Revisor obrigatório |
|---|---|---|---|
| Arquitetura / Documentação | `CromoCard-Workspace` | ADRs, C4, DER, diagrama de classes, casos de uso, processo | PO da sprint |
| Backend | `Backend-CromoCard` | API (Node + Express + Prisma), migrations, testes | Responsável de Backend ou outro dev de backend |
| Serviço de tempo real | _a definir (ADR-0007/ADR-0013)_ | WebSocket do chat | Responsável de Backend |
| Frontend Web | `CromoCard-Frontend` | React + Vite, incluindo a área administrativa | Responsável de Frontend ou outro dev de frontend |
| Mobile | _a definir (ADR-0003/ADR-0013)_ | React Native, incluindo a área administrativa | Responsável de Frontend |
| Infraestrutura | No repositório do app que ela atende | `Dockerfile`, `docker-compose`, `.github/workflows`, `.env.example` | Responsável de Infra + responsável da frente do app |

- Quem são o PO e os responsáveis de cada frente: tabela em
  [`governanca-e-acessos.md`](docs/Processo/governanca-e-acessos.md#2-time-e-contas).
- PR de código que muda regra de negócio também pede revisão do PO (como segundo revisor).
- Todo mundo tem acesso de escrita a todos os repositórios: qualquer pessoa pode abrir PR em
  qualquer repo. O que controla o que entra é a revisão.

---

## 4. Azure DevOps: a Task

### Hierarquia

```
Epic ─► Feature (área funcional) ─► User Story (CCD0xx) ─► Task   ◄── só a Task vira branch
                                                         └► Bug    ◄── Bug também vira branch (fix/)
```

### Campos obrigatórios da Task

| Campo | Exemplo |
|---|---|
| **Title** | Ação técnica: `Criar endpoint POST /auth/login`, `Ajustar ADRs conforme revisão do PO` |
| **Parent** | A User Story (ou, em processo/documentação, a Feature do épico `#84`) |
| **Area Path** | `CromoCard\Arquitetura`, `\Backend`, `\Frontend` ou `\Infraestrutura` |
| **Iteration Path** | A sprint atual (`Sprint 04`) |
| **Assigned To** | Quem vai fazer |
| **Description** | O que precisa ser feito e o critério de pronto |

### Definition of Ready — a Task pode começar quando:

- [ ] todos os campos acima estão preenchidos;
- [ ] cabe em **até 2 dias** de trabalho (se não, quebre em mais Tasks);
- [ ] está claro o critério de pronto;
- [ ] as Tasks de que ela depende estão `Closed`, ou têm link **Predecessor** (ver seção 9).

### Definition of Done — a Task está pronta quando:

- [ ] o PR foi aprovado e mergeado em `development`;
- [ ] os checks automáticos passaram (quando existirem);
- [ ] documentação/diagramas afetados foram atualizados, ou existe Task aberta para isso;
- [ ] a Task está `Closed` no Azure, com o PR vinculado.

### Estados

| Estado | Quando | Quem move |
|---|---|---|
| `New` | Criada, ninguém pegou | — |
| `Active` | Você criou a branch e começou | Você |
| `Resolved` | PR aberto, aguardando revisão | Você |
| `Closed` | PR mergeado em `development` | Automático (`Fixes AB#id`) |

---

## 5. Branches

### Permanentes (protegidas — só recebem PR)

| Branch | Para que serve | Recebe PR de |
|---|---|---|
| `development` | Integração do dia a dia. Branch padrão de todos os repositórios | branches de Task |
| `homolog` | Ambiente de homologação (só nos apps) | `development`, no fim da sprint |
| `main` | Versão estável, apresentada na banca / produção | `homolog` (apps) ou `development` (Workspace) |

```
Apps:       task ─► development ─► homolog ─► main  (+ tag v0.NN.0)
Workspace:  task ─► development ─────────────► main  (+ tag v0.NN.0)
```

### De Task (temporárias — apagadas após o merge)

Formato: **`<tipo>/<id>-<descricao-curta>`**

- `<tipo>`: o mesmo tipo de commit da seção 6 (`feat`, `fix`, `docs`, `refactor`, `test`, `ci`, `build`, `chore`).
- `<id>`: o número da Task (ou do Bug) no Azure.
- `<descricao-curta>`: 2 a 5 palavras, minúsculas, com hífen, sem acento.

| Exemplo | Repositório |
|---|---|
| `docs/319-revisao-adrs` | Workspace |
| `feat/312-endpoint-login` | Backend |
| `feat/318-tela-login` | Frontend |
| `fix/330-progresso-album` | Backend |
| `ci/340-pipeline-backend` | Backend (infra) |
| `hotfix/351-login-quebrado` | Qualquer app (só na exceção da seção 11) |

Toda branch nasce **de `development` atualizada** (exceto `hotfix/`, que nasce de `main`).

---

## 6. Commits — Conventional Commits (em português)

```
<tipo>(<escopo>): <descrição curta no imperativo>

<corpo opcional — o porquê, não o que o diff já mostra>

AB#<id>
```

### Tipos

| Tipo | Quando usar |
|---|---|
| `feat` | Nova funcionalidade (código dos apps) |
| `fix` | Correção de bug |
| `docs` | Documentação — casos de uso, diagramas, ADRs, READMEs |
| `refactor` | Reorganização sem mudar comportamento |
| `test` | Testes automatizados |
| `style` | Formatação/lint, sem mudança de lógica |
| `perf` | Melhoria de performance |
| `ci` | Pipelines (`.github/workflows`) |
| `build` | Docker, empacotamento, dependências de build |
| `chore` | Manutenção (`.gitignore`, config de editor, PR de release) |

### Escopos

Lista fechada por repositório. Precisa de um novo? Adicione aqui no mesmo PR.

| Repositório | Escopos |
|---|---|
| Workspace | `adr`, `der`, `c4`, `diagrama-classes`, `casos-de-uso`, `atividades`, `board`, `banca`, `processo` |
| Backend | `auth`, `users`, `colecao`, `catalogo`, `comunidade`, `chat`, `perfil`, `notificacoes`, `pagamentos`, `admin`, `database`, `infra` |
| Frontend | `auth`, `colecao`, `catalogo`, `comunidade`, `chat`, `perfil`, `notificacoes`, `marketplace`, `admin`, `ui`, `infra` |

### Regras

- Descrição: verbo no imperativo, minúscula, sem ponto final, até ~72 caracteres.
  ✅ `adiciona`, `corrige`, `remove` — ❌ `Adicionado`, `Adiciona.`, `ADICIONA`.
- Pode haver vários commits na branch; no merge eles viram um só (squash).
- **Rodapé `AB#<id>` sempre.** ⚠️ `#270` sem `AB` liga à issue/PR 270 **do GitHub**, não ao Azure.
- Nunca use `git add -A` / `git add .` sem antes rodar `git status`.
- Nunca commite `.env`, senhas, tokens ou chaves. Variável nova vai no `.env.example`, sem valor real.

### Exemplos

```
docs(adr): ajusta ADR-0001 para área administrativa dentro do app web e mobile

O PO decidiu que o backoffice não será uma aplicação separada,
e sim uma área restrita a usuários ADMINISTRADOR.

AB#319
```

```
feat(auth): cria endpoint POST /auth/login com emissão de JWT

AB#312
```

---

## 7. Pull Requests

### Abrir

- **Base:** `development` · **Compare:** a sua branch.
- **Título:** formato de commit + Task → `docs(adr): aplica revisão do PO nas ADRs iniciais (AB#319)`.
  O título vira o commit em `development` no squash, por isso ele segue o padrão à risca.
- **Descrição:** o template (`.github/pull_request_template.md`) já vem preenchido no GitHub.
  Complete o `Fixes AB#<id>`: é essa linha que fecha a Task no Azure no merge.
- **Reviewers:** peça o revisor obrigatório da seção 3 (com `CODEOWNERS`, o GitHub pede sozinho).
- Ainda não está pronto, mas quer feedback? Abra como **Draft**.

### Revisar (quem é revisor)

- Revise em até **1 dia útil**. Task parada esperando revisão atrasa o time inteiro.
- Use **Files changed → Review changes**:
  - **Comment**: dúvida ou sugestão que não bloqueia;
  - **Request changes**: precisa mudar antes de entrar;
  - **Approve**: pode entrar.
- Comente **na linha** do problema, dizendo o que mudar e por quê.
- Critério de revisão de código: Clean Code, SOLID, Object Calisthenics e design patterns
  adequados (skill `code-review-daniel`). Em documentação: está correto, completo e coerente com
  o DER/C4/ADRs?

### Responder à revisão (quem é autor)

- Corrija **na mesma branch**: novo commit + `git push`. O PR atualiza sozinho.
- Responda cada comentário (o que fez, ou por que não fez) e clique em **Resolve conversation**.
- Peça nova revisão no ícone 🔄 ao lado do nome do revisor.

### Merge

- Só com **1 aprovação**, conversas resolvidas e checks verdes.
- **Squash and merge** — quem faz é o **autor**, depois da aprovação.
- A branch é apagada automaticamente (ou clique **Delete branch**).

---

## 8. Passo a passo completo de uma Task

### Antes da primeira Task (uma vez só)

```bash
git config --global user.name "Nome Sobrenome"            # seu nome real
git config --global user.email "email-da-conta-github@exemplo.com"
```

Depois, siga o onboarding em [`governanca-e-acessos.md`](docs/Processo/governanca-e-acessos.md#6-entrada-de-uma-pessoa-nova-onboarding).

### Para cada Task

| # | Onde | Quem | O que fazer |
|---|---|---|---|
| 1 | Azure | Você | Abra a Task. Confira a *Definition of Ready* (seção 4). Atribua a você e mude para **Active** |
| 2 | Terminal | Você | Atualize a `development` e crie a branch (bloco abaixo, passos 2–3) |
| 3 | Editor | Você | Faça o trabalho. Commits pequenos, com `AB#<id>` (passo 4) |
| 4 | Terminal | Você | Publique a branch e abra o PR (passos 5–6) |
| 5 | GitHub | Você | Preencha o template, confira o título, peça o revisor |
| 6 | Azure | Você | Mude a Task para **Resolved** |
| 7 | GitHub | Revisor | Revisa em até 1 dia útil: Approve ou Request changes |
| 8 | Terminal | Você | Se pediram mudanças: corrija, commit, push (passo 4 de novo) e responda os comentários |
| 9 | GitHub | Você | Aprovado e checks verdes: **Squash and merge** |
| 10 | Azure | Automático | A Task vai para **Closed**. Confira se o PR aparece em *Development* |
| 11 | Terminal | Você | Volte para a `development` e apague a branch local (passo 7) |

```bash
# 2. Atualizar a development
git switch development
git pull

# 3. Criar a branch da Task
git switch -c docs/319-revisao-adrs

# 4. Trabalhar e commitar (repita quantas vezes precisar)
git status
git add docs/ADR/0001-separacao-de-clientes-por-plataforma.md
git commit -m "docs(adr): ajusta ADR-0001 conforme revisão do PO" -m "AB#319"

# 5. Publicar
git push -u origin docs/319-revisao-adrs

# 6. Abrir o PR (ou pelo botão "Compare & pull request" no GitHub)
gh pr create --base development --title "docs(adr): aplica revisão do PO nas ADRs iniciais (AB#319)"

# Se a development andou enquanto você trabalhava, traga as novidades:
git fetch origin
git merge origin/development

# 7. Depois do merge
git switch development
git pull
git branch -d docs/319-revisao-adrs
```

---

## 9. Trabalho entre frentes

**Dependência entre Tasks.** Quando uma Task só pode começar depois de outra (ex.: a tela de login
depende do endpoint de login), ligue as duas no Azure: *Links → Add link → Predecessor*. A Task
dependente não entra em `Active` antes da outra estar `Closed`.

**Contrato da API (backend ↔ frontend).**
- O contrato oficial é o **Swagger do backend** (`/docs`). A Task do backend só fecha com o
  endpoint documentado ali.
- Endpoint novo ou alterado: a Task do backend vem antes, e a do frontend tem link Predecessor para ela.
- Mudança que quebra o contrato (renomear campo, mudar status HTTP) avisa o responsável de Frontend
  **no PR**, marcando a pessoa com `@`.

**Banco de dados (Prisma).**
- **Uma migration por PR**, criada com `npm run db:migrate -- --name <acao>_<tabela>`.
- Antes do merge, traga a `development` (`git merge origin/development`) e confira se não entrou
  outra migration depois da sua. Se entrou, recrie a sua por cima.
- Toda mudança de tabela atualiza o DER no Workspace: abra a Task de documentação junto
  (área Arquitetura), com link para a Task do backend.

**Arquitetura que muda no código.** Se a implementação contradiz um ADR, C4 ou DER, pare e abra
uma Task de arquitetura (ADR nova ou revisão) antes de seguir.

**Segredos e ambientes.**
- Valores reais de `.env` nunca vão para o Git. Ficam com o responsável de Infra e, no CI, em
  *Settings → Secrets and variables → Actions*, cadastrados pelo admin.
- Credenciais de sandbox (Mercado Pago, Melhor Envio) só em `homolog`; de produção só em `main`.

---

## 10. Fim de sprint: release

Quem faz: **PO da sprint**, depois da Review.

| # | O que fazer |
|---|---|
| 1 | Confira no Azure que todas as Tasks da sprint estão `Closed` ou movidas para a próxima |
| 2 | Apps: abra PR `development → homolog`, título `chore(release): Sprint NN`, descrição com a lista das Tasks (`AB#...`). Workspace: PR direto para `main` |
| 3 | Valide em homologação. Depois abra PR `homolog → main`, mesmo título |
| 4 | Nesses PRs use **Create a merge commit** (não squash), para preservar o histórico |
| 5 | Em `main`, crie a tag e a Release: GitHub → *Releases → Draft a new release* → tag `v0.NN.0` (ex.: Sprint 04 = `v0.4.0`), target `main`, **Generate release notes** |

A versão segue SemVer: `v0.<sprint>.<correção>`. A versão `v1.0.0` fica para a entrega final do MVP.

---

## 11. Correção urgente (hotfix)

**Regra geral:** bug encontrado em `homolog` ou `main` vira **Bug** no Azure e segue o fluxo normal
(`fix/<id>-...` a partir de `development`), entrando na próxima release.

**Exceção** — só com autorização do PO da sprint, quando o bug impede a demonstração/uso e não dá
para esperar a sprint:

```bash
git switch main && git pull
git switch -c hotfix/351-login-quebrado
# corrige, commit com AB#351, push
# PR hotfix/351-login-quebrado ─► main  (1 aprovação, squash)
# tag v0.NN.1 em main
# PR main ─► development (merge commit), para a correção não se perder
```

---

## 12. Erros comuns e como corrigir

| Situação | O que fazer |
|---|---|
| Commitei em `development` local e **não** dei push | `git switch -c <tipo>/<id>-<desc>` (leva os commits junto), `git switch development`, `git reset --hard origin/development` |
| O push direto foi recusado | É a proteção funcionando. Faça o item acima e abra PR |
| Esqueci o `AB#id` no commit | Tudo bem se o PR tiver `Fixes AB#id`: no squash, a descrição do PR entra no commit |
| Branch com nome errado (ainda sem PR) | `git branch -m <nome-novo>`, `git push -u origin <nome-novo>`, apague a antiga no GitHub |
| Conflito no PR | `git fetch origin && git merge origin/development`, resolva, commit, push |
| Task não existe no Azure | Crie a Task (filha da User Story certa) **antes** de criar a branch |
| A Task cresceu demais | Entregue o que está pronto neste PR e crie uma nova Task para o restante |
| O revisor sumiu | Após 1 dia útil, marque-o no PR com `@`. Após 2, peça outro revisor da mesma frente |
| Feedback chegou fora do PR (grupo, Issue, reunião) | Copie para o PR como comentário, para ficar registrado |

---

## 13. ADRs e diagramas

**ADRs**
- Ficam em `docs/ADR/`, uma por arquivo (`00NN-titulo.md`), indexadas em `docs/ADR/README.md`.
- Toda ADR nova entra por PR com **`Status: Pendente`**. A aprovação do PO **no PR** muda o status
  para `Aceita`/`Rejeitada`/`Substituída` (pode ser no mesmo PR, num commit final).
- Crie uma ADR quando: escolher uma tecnologia/biblioteca nova, mudar algo que os diagramas já
  davam como decidido, mudar o processo do time, ou resolver uma decisão em aberto.

**Diagramas**
- `docs/Diagramas/DER/dbdiagram.io/03-der-completo.dbml` é a fonte da verdade do modelo de dados —
  os `.sql` e `.puml` são derivados dele.
- O diagrama de classes deve continuar 1:1 com o DER (ADR-0016): entidade alterada no DER, classe
  alterada no mesmo PR.
- Exporte em **SVG**, nunca PNG (o servidor público do PlantUML corta PNG em 4096px).

---

## 14. Referências

O padrão combina práticas conhecidas. Nenhuma metodologia ágil (Scrum, XP) define versionamento,
mas o fluxo apoia a *Definition of Done* e o *Incremento* do Scrum, e a integração contínua e a
revisão por pares do XP.

| Parte do padrão | Nome / origem | Referência |
|---|---|---|
| `development → homolog → main` | GitLab Flow (*environment branches*) | https://about.gitlab.com/topics/version-control/what-is-gitlab-flow/ |
| 1 branch por Task + PR | Feature Branch Workflow / GitHub Flow | https://docs.github.com/pt/get-started/using-github/github-flow |
| Mensagens de commit | Conventional Commits 1.0.0 | https://www.conventionalcommits.org/pt-br/v1.0.0/ |
| Versões `v0.NN.0` | Semantic Versioning 2.0.0 | https://semver.org/lang/pt-BR/ |
| `AB#id` / `Fixes AB#id` | Integração Azure Boards ↔ GitHub | https://learn.microsoft.com/pt-br/azure/devops/boards/github/link-to-from-github |
| Revisores por pasta | GitHub CODEOWNERS | https://docs.github.com/pt/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners |
| Proteção das branches | GitHub Rulesets | https://docs.github.com/pt/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets |
| Alternativa descartada | GitFlow (Vincent Driessen, 2010) | https://nvie.com/posts/a-successful-git-branching-model/ |
| Direção futura | Trunk-Based Development / DORA | https://trunkbaseddevelopment.com/ · https://dora.dev/capabilities/trunk-based-development/ |
