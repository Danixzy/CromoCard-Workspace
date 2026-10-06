# Como contribuir — CromoCard

Guia de trabalho para todos os repositórios de código do CromoCard. As decisões por
trás de cada regra estão em `docs/ADR/`.

## 1. Preparar o ambiente

```bash
nvm use                 # usa a versão do Node do .nvmrc
npm ci                  # instala exatamente o que está no package-lock.json
cp .env.example .env    # ajuste os valores locais
docker compose up -d    # sobe PostgreSQL (e MinIO, se usado)
npm run db:migrate      # aplica as migrations
npm run db:seed         # dados iniciais
npm run dev             # sobe a API em modo watch
```

- Use sempre **npm**. Não use yarn ou pnpm, porque um lockfile diferente causa conflito.
- Nunca faça commit do `.env`. Variável nova vai para o `.env.example`, com um valor de exemplo.

## 2. Pegar uma tarefa

1. A tarefa precisa existir no **Azure Boards** (user story ou task) e estar atribuída a você.
2. Mova o card para *Active* quando começar.

## 3. Branches (Git Flow — ADR-013)

```
main  ←  homolog  ←  development  ←  feature/<id>-<descricao>
```

```bash
git switch development && git pull
git switch -c feature/120-marcar-carta-possuo
```

| Prefixo | Quando usar | Sai de | Volta para |
|---|---|---|---|
| `feature/` | Nova funcionalidade | `development` | `development` |
| `fix/` | Bug encontrado em dev/homolog | `development` | `development` |
| `hotfix/` | Bug urgente em produção | `main` | `main` **e** `homolog` **e** `development` |

`<id>` é o número do work item no Azure Boards. A descrição vai em minúsculas, com hífens e sem acentos.

## 4. Commits (Conventional Commits)

```
<tipo>(<escopo>): <o que foi feito, no presente>

AB#<id>
```

Exemplos:
```
feat(collection): marca carta como possuo
fix(auth): corrige expiração do refresh token
test(users): cobre cadastro com e-mail duplicado
```

| Tipo | Uso |
|---|---|
| `feat` | Funcionalidade nova |
| `fix` | Correção de bug |
| `refactor` | Mudança de código sem mudar comportamento |
| `test` | Só testes |
| `docs` | Só documentação |
| `chore` | Manutenção (dependências, configs) |
| `ci` / `build` | Pipeline e build |
| `perf` / `style` | Performance / formatação |

- O escopo é o domínio: `auth`, `users`, `catalog`, `collection`, `community`, `chat`, `marketplace`, `notifications`, `admin`.
- O `AB#<id>` liga o commit ao card do Azure Boards.
- O hook do husky valida a mensagem. Um commit fora do padrão é recusado.

## 5. Padrões de código

**Idioma**
- Código em **inglês** (nomes de variáveis, funções, arquivos, rotas e códigos de erro).
- Comentários em **português**, explicando o **porquê**:
  ```ts
  // O UUID v7 é ordenado por tempo, então dá para paginar pelo id sem índice extra em created_at
  ```
- Mensagens para o usuário (`message` dos erros, e-mails) em português.

**Estrutura** (ADR-004): cada domínio em `src/domains/<dominio>/` com
`routes · controller · service · repository · validator · errors · swagger · module` + `service.spec.ts`.

**Regras que o code review cobra**
- O controller não tem regra de negócio. A service não conhece `req`/`res`.
- Um domínio **nunca** importa o repository de outro, só a service exportada pelo `.module.ts` dele.
- As dependências entram pelo construtor. Não se faz `new` de dependência dentro da classe.
- Toda entrada é validada por um schema Zod no `.validator.ts`.
- Erro de negócio = classe que estende `AppError` no `.errors.ts`. Não use `throw new Error('...')` solto.
- Toda consulta filtra `deletedAt: null`. Excluir = preencher `deletedAt` (ADR-015).
- Imports internos com `@/` (`@/shared/errors`), nunca `../../../`.
- `console.log` é proibido. Use o logger.
- Nomes: `PascalCase` para classes e tipos, `camelCase` para variáveis e funções, `UPPER_SNAKE_CASE` para constantes.
- Clean Code, SOLID e Object Calisthenics: funções pequenas, um nível de indentação quando possível, sem `else` desnecessário, nomes que explicam a intenção.

**Testes** (ADR-008)
- Toda service nova ou alterada tem `.spec.ts` cobrindo o caminho feliz e os erros.
- Cobertura mínima de 80% nas services. O CI falha abaixo disso.

Antes de abrir o PR:
```bash
npm run lint && npm run typecheck && npm run test:cov
```

## 6. Pull Request

1. Faça push da branch e abra um PR para `development`.
2. O template de PR é preenchido automaticamente. **Preencha tudo.**
3. É preciso **1 aprovação** + **CI verde**.
4. Merge com **squash** (1 commit por feature). Apague a branch depois do merge.
5. Um PR = uma user story. PR grande demais deve ser dividido.

**Quem revisa:** olha regra de negócio, os padrões acima e os testes. O comentário é
sobre o código, não sobre a pessoa. Sugestões opcionais começam com "nit:".

## 7. Definição de pronto (DoD)

Uma tarefa só está **pronta** quando:

- [ ] Atende os critérios de aceite do caso de uso / user story
- [ ] Lint, typecheck e testes passam no CI
- [ ] Services com teste e cobertura ≥ 80%
- [ ] Endpoint documentado no Swagger (`.swagger.ts`)
- [ ] Migration criada, se houve mudança no banco (e o DER foi atualizado)
- [ ] PR aprovado e mergeado em `development`
- [ ] Card movido para *Closed* no Azure Boards

## 8. Mudou uma decisão de arquitetura?

Não mude o padrão sozinho no código. Proponha um **ADR novo** em `docs/ADR/`
(modelo no `README.md` da pasta) e discuta com a equipe.
