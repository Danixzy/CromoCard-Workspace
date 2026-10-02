# ADR-0018: Estratégia de versionamento e rastreabilidade Azure DevOps ↔ GitHub

## Status

**Pendente** — proposto em 02/10/2026, aguardando validação do PO.

## Contexto

O projeto tem três repositórios Git independentes (ADR-0013): `CromoCard-Workspace` (arquitetura e
documentação), `Backend-CromoCard` e `CromoCard-Frontend`. Seis pessoas trabalham neles, divididas
entre arquitetura, backend, frontend e infraestrutura. O planejamento acontece no Azure DevOps
(Epic → Feature → User Story → Task) e o código e os documentos são entregues no GitHub.

Até aqui não havia regra comum de versionamento, e isso gerou três problemas:

- **Commits direto em `development`.** O `CONTRIBUTING.md` original orientava "todo mundo
  commita/dá push aqui no dia a dia". As ADRs 0001–0017 entraram assim, sem revisão prévia, e a
  revisão do PO acabou registrada numa Issue separada (issue #1 do `CromoCard-Workspace`), sem
  vínculo com as linhas alteradas.
- **Sem vínculo entre entrega e Task.** Os commits citavam `Refs #270`, mas no GitHub `#270`
  aponta para a issue/PR 270 do próprio GitHub, não para o work item do Azure. Nem o board nem o
  repositório mostram o que foi entregue para cada Task.
- **Cada repositório com um modelo de branch.** O Workspace só tem `development`. Os apps têm
  `main`, `homolog` e `development`, e o backend já usa branch de feature com PR
  (`feature/esqueleto-backend`, PR #1).
- **Acessos sem controle.** Levantamento de 02/10/2026: os três repositórios estão na conta
  pessoal de um integrante, nenhum tem proteção de branch (qualquer colaborador pode dar push ou
  force push em `main`), e os colaboradores não são os mesmos em cada repositório.

O projeto é longo (MVP com marketplace, web, mobile, tempo real e duas integrações externas) e
precisa de um processo auditável e que continue funcionando quando o time, o PO da sprint ou as
frentes mudarem.

## Decisão

Adotar um único modelo de versionamento nos três repositórios, com a **Task do Azure DevOps como
unidade de entrega**:

1. **Branches de ambiente (GitLab Flow):** `development` (integração, branch padrão), `homolog`
   (homologação, só nos apps) e `main` (versão estável). O código só sobe nesse sentido:
   `development → homolog → main` nos apps e `development → main` no Workspace. Ninguém faz push
   direto nessas branches.
2. **Feature branch por Task:** 1 Task = 1 branch `<tipo>/<id-da-task>-<descricao>` saída de
   `development` = 1 Pull Request para `development`.
3. **Conventional Commits 1.0.0, em português**, com escopos fechados por repositório e rodapé
   `AB#<id>` em todo commit.
4. **Rastreabilidade pela integração Azure Boards ↔ GitHub:** o PR leva `Fixes AB#<id>` na
   descrição, o que vincula o PR à Task e fecha a Task quando o merge cai na branch padrão.
5. **Revisão obrigatória no próprio PR:** 1 aprovação, nunca do autor. O PO aprova o que é
   arquitetura/documentação e um dev da mesma frente aprova o código. O feedback fica no review do
   PR, não em Issue.
6. **Squash and merge** nos PRs de Task (1 commit por Task em `development`, com título e
   descrição do PR) e **merge commit** nos PRs de promoção de fim de sprint
   (`chore(release): Sprint NN`).
7. **Versão por sprint:** cada promoção para `main` recebe tag e GitHub Release `v0.<sprint>.0`
   (SemVer). Hotfix só como exceção autorizada pelo PO, saindo de `main` (`v0.<sprint>.1`).
8. **Papéis e acessos:** Admin (+ substituto), PO da sprint (rotativo), Responsável de frente e Dev.
   Todos têm Write em todos os repositórios; o que controla a entrada é a revisão obrigatória,
   garantida por **rulesets** nas branches permanentes (PR obrigatório, 1 aprovação, sem force push,
   sem bypass) e por **CODEOWNERS** apontando o revisor de cada pasta.
9. **Organização do GitHub** no lugar da conta pessoal, com times por frente e um time `po` cujo
   membro troca a cada sprint, e **Issues do GitHub desativadas**: o backlog é só o Azure.

As regras operacionais ficam em:
- `CONTRIBUTING.md` — passo a passo de uma Task, revisão, release, hotfix, trabalho entre frentes;
- `docs/Processo/governanca-e-acessos.md` — papéis, matriz de acessos, checklist de configuração,
  auditoria e onboarding;
- `.github/pull_request_template.md`.

## Alternativas consideradas

- **Commit direto em `development` (modelo anterior).** Mais simples, mas sem revisão antes da
  entrega e sem vínculo com o Azure. Foi exatamente o que gerou o problema descrito no contexto.
- **GitFlow (Driessen, 2010).** Acrescenta `release/*` e `hotfix/*` ao modelo. Descartado porque
  não há versões publicadas em paralelo nem produção com correção urgente: as branches extras
  seriam cerimônia sem ganho para um time acadêmico de seis pessoas.
- **GitHub Flow puro (só `main` + feature branches).** Simples, mas não tem ambiente de
  homologação, que os apps já criaram e que o PO usa para validar a sprint antes da banca.
- **Trunk-Based Development.** Branches de horas, integradas direto na principal e protegidas por
  feature flags. É o modelo associado aos times de melhor desempenho no relatório DORA/Accelerate,
  mas exige CI automatizado, testes confiáveis e experiência com feature flags, que o projeto ainda
  não tem. Fica como direção futura: manter as Tasks pequenas para que as branches durem pouco.
- **Uma branch por User Story** em vez de por Task. Daria PRs grandes e misturaria frentes (uma
  User Story costuma ter Tasks de backend e frontend, que estão em repositórios diferentes).
- **Manter a conta pessoal** com colaboradores individuais. Funciona com rulesets (os repositórios
  são públicos), mas não tem times nem log de auditoria, todo colaborador tem o mesmo papel e um
  único admin é ponto único de falha. Fica como alternativa mínima se a organização não for criada.
- **Restringir o acesso de escrita por frente.** Mais rígido, mas impede que alguém de uma frente
  corrija um documento ou ajude em outra. A revisão obrigatória por CODEOWNERS dá o mesmo controle
  sem bloquear a colaboração.

## Consequências

**Positivas**
- Cada Task do Azure mostra os commits e o PR que a entregaram, e cada PR aponta para a Task: a
  rastreabilidade fica nos dois sentidos, sem esforço manual.
- A revisão do PO fica registrada no PR, junto das linhas alteradas, e a aprovação vira a evidência
  de pronto (*Definition of Done*) da Task.
- O mesmo fluxo vale para arquitetura, backend, frontend e infraestrutura: quem troca de frente não
  precisa aprender outro processo.
- O histórico de `development` fica com um commit por Task, filtrável por tipo e escopo
  (`git log --grep="feat(auth)"`).

- Cada sprint vira uma versão identificável (`v0.NN.0`) com a lista do que entrou.
- Trocar o PO da sprint ou alguém do time não exige mudar regra nenhuma, só a tabela de papéis e
  os membros dos times do GitHub.

**Negativas / riscos**
- Mais passos por entrega (branch, PR, espera pela revisão). Se a revisão demorar, as Tasks param:
  o PO e os revisores precisam olhar os PRs com frequência.
- A automação depende de configuração que só o admin pode fazer: app Azure Boards instalado e
  conectado, proteção das branches e `development` como branch padrão em todos os repositórios.
  Sem a proteção, a regra de "não commitar direto" depende só da disciplina do time.
- Uma Task que dura muito gera branch longa e conflitos. A mitigação é quebrar Tasks grandes.
- Exige que toda entrega tenha Task no Azure antes de começar.
- Transferir os repositórios para uma organização muda as URLs (o GitHub redireciona as antigas,
  mas os clones locais devem atualizar o `remote`).

## Decisões em aberto

- **Organização do GitHub ou conta pessoal** — decisão do admin; registrar aqui o resultado.
- **Repositório do Mobile (ADR-0003) e do serviço de tempo real (ADR-0007)** — não existem hoje.
  Sugestão: tempo real dentro do `Backend-CromoCard` (mesmo JWT e Prisma, container separado) e
  um repositório `CromoCard-Mobile` quando o mobile começar. Atualizar o ADR-0013 quando decidido.
- **Responsáveis de cada frente** — definir na próxima Planning e registrar em
  `docs/Processo/governanca-e-acessos.md`.

## Referências

- `CONTRIBUTING.md` — guia operacional desta decisão
- `.github/pull_request_template.md`
- `docs/Processo/governanca-e-acessos.md` — papéis, acessos, auditoria e onboarding
- ADR-0013 — estrutura multi-repositório
- Semantic Versioning 2.0.0 — https://semver.org/lang/pt-BR/
- GitHub Rulesets — https://docs.github.com/pt/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets
- GitHub CODEOWNERS — https://docs.github.com/pt/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners
- Conventional Commits 1.0.0 — https://www.conventionalcommits.org/pt-br/v1.0.0/
- GitLab Flow — https://about.gitlab.com/topics/version-control/what-is-gitlab-flow/
- GitHub Flow — https://docs.github.com/pt/get-started/using-github/github-flow
- GitFlow (Vincent Driessen) — https://nvie.com/posts/a-successful-git-branching-model/
- Trunk-Based Development — https://trunkbaseddevelopment.com/
- DORA — https://dora.dev/capabilities/trunk-based-development/
- Vincular GitHub ao Azure Boards (`AB#`) — https://learn.microsoft.com/pt-br/azure/devops/boards/github/link-to-from-github
