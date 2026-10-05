# ADR-017 — Convenções de código e contribuição

- **Status:** Aceito
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard

## Contexto

Seis pessoas escrevendo no mesmo código precisam das mesmas regras para idioma, nomes,
imports, gerenciador de pacotes e processo de PR. As regras que o lint consegue
verificar ficam no ESLint (ADR-008). As demais ficam num guia escrito.

## Decisão

| Tema | Regra |
|---|---|
| Idioma do **código** | Inglês: variáveis, funções, classes, arquivos, tabelas, rotas e códigos de erro |
| Idioma dos **comentários** | **Português (pt-BR)** |
| Idioma de commits e PRs | Português (Conventional Commits, ADR-013) |
| Mensagens ao usuário | Português (`message` dos erros, e-mails) |
| Gerenciador de pacotes | **npm**. O `package-lock.json` é versionado, e o CI usa `npm ci` |
| Versão do Node | Fixada em `.nvmrc` e em `engines` (ADR-002) |
| Imports internos | Alias **`@/`** → `src/` (`import { AppError } from '@/shared/errors'`), nunca `../../../` |
| Nomes de arquivo | `<dominio>.<papel>.ts` em minúsculo (ADR-004) |
| Classes / tipos | `PascalCase`; variáveis e funções em `camelCase`; constantes globais em `UPPER_SNAKE_CASE` |
| `console.log` | Proibido (regra do ESLint). Use o logger |
| Comentários | Explicam o **porquê**, não o **quê**. O código deve ser legível sem eles |
| PR | Segue o **template de PR** e o checklist de "pronto" |

**Documentos:**
- `docs/Padroes/CONTRIBUTING.md`: o guia completo (como rodar, fluxo de branch, commits, PR, padrões de código e definição de pronto).
- `docs/Padroes/pull_request_template.md`: o template de PR.

Os dois são copiados para cada repositório de código na criação do esqueleto
(`CONTRIBUTING.md` na raiz e `.github/pull_request_template.md`). O GitHub passa a
preencher o template automaticamente em todo PR novo.

## Alternativas consideradas

- **Comentários em inglês:** deixaria tudo num idioma só, mas a equipe, o professor e a
  documentação são em português. Comentário serve para ser entendido pela equipe.
- **pnpm / yarn:** o pnpm é mais rápido e economiza disco, mas o npm já vem com o Node,
  e ninguém precisa instalar nada a mais.

## Consequências

- Código em inglês com comentários em português é uma mistura intencional e documentada.
- Qualquer pessoa nova segue o `CONTRIBUTING.md` sem precisar perguntar.
