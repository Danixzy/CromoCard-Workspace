# ADR-013 — Fluxo de branches: Git Flow (main · homolog · development · feature)

- **Status:** Aceito
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard

## Contexto

Seis pessoas trabalham nos repositórios `Backend-CromoCard` e `CromoCard-Frontend`
(e no repositório de documentação). É preciso separar o que está em
desenvolvimento, o que está em teste (homologação) e o que está em produção.

## Decisão

### Branches
| Branch | Papel | Deploy | Recebe merge de |
|---|---|---|---|
| `main` | Produção. Cada merge gera uma tag `vX.Y.Z` | Produção | `homolog`, `hotfix/*` |
| `homolog` | Homologação: o que a equipe/professor valida antes de ir para produção | Homologação | `development`, `hotfix/*` |
| `development` | Integração do dia a dia | (opcional) ambiente de dev | `feature/*`, `fix/*` |
| `feature/<id>-<descricao>` | Uma user story ou task | — | — |
| `fix/<id>-<descricao>` | Correção de bug encontrado em `development`/`homolog` | — | — |
| `hotfix/<descricao>` | Correção urgente em produção | — | — |

- `<id>` é o número do work item no Azure Boards: `feature/120-marcar-carta-possuo`.
- `feature/*` e `fix/*` saem de `development` e voltam para `development`.
- `hotfix/*` sai de `main`, entra em `main` e **volta** para `homolog` e `development`
  (senão a correção se perde no próximo deploy).
- Branches de feature são apagadas depois do merge.

### Regras (branch protection nas 3 branches fixas)
- Proibido push direto. Toda mudança entra via **Pull Request**.
- PR precisa de **1 aprovação** e do **CI verde** (lint, typecheck, testes, build — ADR-008).
- PR pequeno: uma user story por PR.
- Em PR de feature → `development`, usar **squash merge** (1 commit por feature). Nas
  promoções `development → homolog → main`, usar **merge commit**, para preservar o histórico.

### Commits: Conventional Commits (em português)
```
<tipo>(<escopo opcional>): <descrição no imperativo>

AB#120
```
- Tipos: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `ci`, `build`, `perf`, `style`.
- Escopo = domínio: `feat(collection): marca carta como possuo`.
- `AB#<id>` liga o commit/PR ao work item do Azure Boards (via app Azure Boards no GitHub).
- Validado pelo `commitlint` no hook `commit-msg` do husky.

### Versionamento
- SemVer (`MAJOR.MINOR.PATCH`), com tag criada no merge em `main`.

## Alternativas consideradas

- **GitHub Flow / trunk-based** (só `main` + branches curtas): mais simples e mais
  rápido, mas a equipe quer um ambiente de homologação explícito antes da produção.
- **Git Flow clássico com `release/*`:** o papel da `release/*` é cumprido pela `homolog`, que é permanente.

## Consequências

- Três ambientes precisam existir (ou pelo menos `homolog` e `main`) quando o deploy for definido.
- Hotfix exige o merge de volta. Esquecer isso é o erro mais comum do Git Flow.
- O histórico da `main` fica limpo e rastreável até o work item.
