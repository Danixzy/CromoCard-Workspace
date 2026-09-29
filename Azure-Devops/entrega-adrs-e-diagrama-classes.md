# Documento de Entrega — ADRs e Refatoração do Diagrama de Classes

> Preparado para anexar/colar nos work items abaixo. **Nada foi alterado no Azure DevOps** — só os
> arquivos deste repositório (`CROMOCARD-WORKSPACE`, branch `development`). Ver
> `CLAUDE.md` — "Nunca altere work items no Azure sem pedido explícito".

**Data:** 29/09/2026
**Épico:** `#269 Arquitetura e documentação técnica`

| User Story                                                       | Tasks                                                                                                                                          | Status desta entrega                                                                                                         |
| ---------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| `#270 Documentação das decisões de arquitetura (ADR)`       | `#272 Levantar decisões arquiteturais já tomadas` · `#273 Redigir as ADRs iniciais` · `#274 Publicar/versionar ADRs no repositório` | #272 e #273 concluídas nesta entrega. **#274 (publicar/versionar) depende de commit — ver seção 3.**               |
| `#271 Revisão da documentação de Diagrama de Classes e DER` | `#275 Revisar Diagrama de Classes` · `#276 Revisar DER`                                                                                   | #275 concluída nesta entrega. #276 (Revisar DER) **fora de escopo** — o DER não foi alterado, só usado como fonte. |

---

## 1. Entrega da User Story #270 — ADRs

### O que foi feito

Levantamento dos artefatos existentes (Diagramas C4, DER, `CLAUDE.md`, board do Azure DevOps) em
busca de decisões arquiteturais que nunca tinham sido formalizadas em documento — só existiam
implícitas nos diagramas, ou (no caso do trabalho anterior do time, `#148`/`#150`/`#152`/`#153`)
só no Azure DevOps, nunca chegaram ao repositório. Essa lacuna já estava documentada em
`Apresentacao-Banca/plano-apresentacao-banca.md` ("ADRs (#150) só no Azure DevOps ❌ Não está no
repositório").

**17 ADRs criadas em `docs/ADR/`, todas com status `Pendente`** (aguardando validação do PO):

| #    | Título                                                                                        |
| ---- | ---------------------------------------------------------------------------------------------- |
| 0001 | Separação das aplicações cliente por plataforma (Web, Mobile, BackOffice)                  |
| 0002 | Stack de frontend para Web e BackOffice: React + Vite                                          |
| 0003 | Stack do aplicativo mobile: React Native                                                       |
| 0004 | Stack de backend: Node.js + Express + Prisma                                                   |
| 0005 | Banco de dados relacional: PostgreSQL via Prisma ORM                                           |
| 0006 | Autenticação via JWT compartilhado entre API REST e serviço de tempo real                   |
| 0007 | Serviço de mensageria em tempo real como container dedicado                                   |
| 0008 | Integração com gateway de pagamento externo via HTTPS/Webhook                                |
| 0009 | Integração com transportadora terceirizada para entrega física                              |
| 0010 | Modelagem polimórfica para alvos de`favorito` e `denuncia`                                |
| 0011 | Convenções de modelagem de dados (nomenclatura, PK, associativas N:N)                        |
| 0012 | Trilha de auditoria obrigatória para ações administrativas                                  |
| 0013 | Estrutura multi-repositório (documentação separada das aplicações)                        |
| 0014 | **Escopo do Marketplace no MVP — decisão ainda em aberto, não uma escolha já feita** |
| 0015 | Herança de tipos de usuário no diagrama de classes (Single Table Inheritance)                |
| 0016 | Granularidade do diagrama de classes (1:1 com as 43 entidades do DER)                          |
| 0017 | Notação de relacionamento no diagrama de classes (rótulo textual)                           |

Índice completo com links: `docs/ADR/README.md`.

### Como validar com o PO

Cada arquivo tem as seções **Contexto**, **Decisão**, **Alternativas consideradas** e
**Consequências**, com referência aos artefatos-fonte. Sugestão de pauta de validação:

1. Abrir com a **ADR-0014** (Marketplace no MVP) — é a única decisão real em aberto, as outras 16
   só formalizam escolhas que os diagramas já mostram.
2. Confirmar as ADRs 0001–0013 (stack e modelagem) em bloco — se o PO concordar com o que já está
   desenhado no C4/DER, é só mudar `Status: Pendente` → `Status: Aceita` em cada arquivo.
3. Confirmar as ADRs 0015–0017 (decisões específicas do diagrama de classes, ver seção 2 abaixo).

### Task #274 — Publicar/versionar ADRs no repositório

Os arquivos estão criados no working tree, mas **não commitados** (aguardando sua revisão antes do
commit). Depois de revisar, faça o commit para fechar a task:

```
git add docs/ADR/
git commit -m "docs: adiciona ADRs iniciais de arquitetura (status pendente)"
```

---

## 2. Entrega da User Story #271 / Task #275 — Revisar Diagrama de Classes

### Diagnóstico do diagrama anterior

O arquivo anterior (`docs/Diagrama de Classe/blank.c4`, feito no C4 Playground/LikeC4) tinha três
problemas, que são a causa provável do retrabalho:

1. **Cobertura parcial** — só 16 classes, praticamente só a fatia do Marketplace. Faltavam
   Usuários/Perfil, Catálogo, Coleção, Comunidade, Chat Pessoal, Notificações e
   Moderação/Administração inteiros (o DER já modelava esses 8 módulos há tempo).
2. **Nenhuma relação entre classes** — nem herança, nem associação. Um diagrama de classes sem
   relações não mostra a estrutura do domínio, só uma lista de campos soltos.
3. **Divergências do DER** — `Vendedor` tinha um atributo `reputacao` sem lastro em nenhuma
   tabela; `Pedido`/`ItemPedido` modelavam um carrinho multi-item, mas no DER cada `pedido`
   referencia um único `anuncio` (não existe `item_pedido`).

### O que foi entregue

- **`docs/Diagrama-de-Classe/cromocard-diagrama-classes.v2.c4`** — diagrama refeito do zero, com
  fidelidade 1:1 ao DER: **43 classes + 22 enumerações**, nos mesmos 8 módulos do DER, com todas
  as relações (herança + associações, ~80 relações) e correção dos três problemas acima. A versão
  anterior do time foi preservada como `cromocard-diagrama-classes.v1.c4`, só para histórico.
- **`docs/Diagrama-de-Classe/README.md`** — legenda de notação, explicação da herança de usuários
  e mapa de rastreabilidade (reaproveita a tabela do `docs/Diagramas/DER/README.md`).
- Pasta renomeada de `Diagrama de Classe` (com espaço) para `Diagrama-de-Classe`, para seguir o
  padrão de nomes do resto do repositório (`Diagramas-C4`, `Casos-De-Uso`).
- `CLAUDE.md` atualizado para listar a nova pasta na estrutura do repositório.
- 3 ADRs específicas desta refatoração (0015, 0016, 0017 — ver seção 1) documentando as decisões
  de modelagem: por que existe herança de tipos de usuário mesmo o DER usando uma tabela só, por
  que o diagrama cobre as 43 entidades (e não um recorte menor), e por que as relações usam
  rótulo textual em vez de setas UML nativas (limitação da ferramenta).

### Views incluídas (para não repetir o erro do diagrama gigante)

Em vez de uma única view com tudo (ilegível, mesmo problema que o DER já resolveu com
`left to right direction`), o arquivo tem **10 views**: uma de destaque só para a herança de
usuários, uma por módulo (8), e uma visão geral completa marcada como "só para conferência, não
para apresentar".

### Pendência para você conferir

- **Ação:** abrir `docs/Diagrama-de-Classe/cromocard-diagrama-classes.v2.c4` em
  [https://likec4.dev/playground](https://likec4.dev/playground) e conferir se renderiza como esperado antes de levar para a
  apresentação — a sintaxe de relação usada (`origem -> destino "rótulo"`) é a mais básica do
  LikeC4, mas vale confirmar visualmente.

---

## 3. Arquivos criados/alterados nesta entrega

```
docs/ADR/README.md                                            (novo — índice)
docs/ADR/0001-...0017-...md                                   (novos — 17 ADRs)
docs/Diagrama-de-Classe/cromocard-diagrama-classes.v2.c4      (novo — versão atual)
docs/Diagrama-de-Classe/cromocard-diagrama-classes.v1.c4      (novo — versão original, histórico)
docs/Diagrama-de-Classe/README.md                              (novo)
Azure-Devops/entrega-adrs-e-diagrama-classes.md                (este documento)
CONTRIBUTING.md                                                (novo — padrão de commits)
CLAUDE.md                                                      (atualizado — estrutura do repo, seção Git)
```

Commitado em 4 partes (ADRs, diagrama de classes, apresentação de banca, guia de contribuição) —
ver `git log --oneline -4` para conferir.
