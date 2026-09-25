# Reorganização do Board — CromoCard Team

> **Documento de apresentação para a equipe.**
> Baseado na **leitura real do board** em 28/08/2026 (org `CromoCard`, projeto
> `CromoCard`, time `CromoCard Team`): 176 work items, 7 Epics, 55 Features,
> 49 User Stories, 47 Tasks, 6 Cerimônias, 4 Bugs, 3 Reuniões, 2 Daily,
> 2 Task Spike, 1 Spike.
>
> **Nada foi alterado no Azure.** Isto é só a proposta.
> Substitui o `organizacao-epicos-azure-boards.md`, que tinha sido escrito só a
> partir da planilha, sem acesso ao board.

**Sprints:** Sprint 01 (06/08 → 20/08, encerrada) · Sprint 02 (20/08 → 03/09, **atual**)

---

## 1. Como o board está hoje

### Os 7 épicos

| # | Epic | Conteúdo | Situação |
|---|---|---|---|
| 5 | `EXEMPLO` | 2 Features, 4 US, 7 Tasks, 4 Bugs, 1 Spike, 1 Reuniões | **Do professor — não tocar** |
| 39 | `CromoCard - Painel Público` | 7 Features (CCD001–CCD006) | Vira Feature |
| 43 | `CromoCard - Painel Cliente` | 38 Features (CCD007–CCD044) | Vira Feature (e precisa quebrar) |
| 47 | `CromoCard - Painel Administrador` | **vazio** | Vira Feature |
| 84 | `Documentacao - CromoCard` | Sprints, cerimônias, C4/ADR, criação das US | Ver seção 3 |
| 98 | `CromoCard - Estrutura` | 1 Feature (`Banco de Dados`) | Vira Feature |
| 185 | `__CromoCard` | 4 Features (Grupos, Marketplace, Transportadora, Gateway) | Vira Feature |

### O que está solto

**28 User Stories sem pai nenhum** (#55 a #82). Não são lixo — são o
**inventário de telas** do produto, e encaixam certinho nas Features:

`Login` · `Cadastro` · `Home` · `Dashboard` · `Meus Albuns` · `Album` ·
`Cadastro de Carta` · `Meu Perfil` · `Notificacoes` · `Favoritos` ·
`Marketplace - Listagem de Cartas` · `Marketplace - detalhes das cartas` ·
`Marketplace - Carrinho` · `Marketplace - Checkout` · `Marketplace - Meus Anuncios` ·
`Minhas Compras` · `Minhas Vendas` · `Grupos - Trocas` · `Grupos - Listagem grupos` ·
`Grupo - chat/conversas` · `Dashboard` (admin) · `Gestao de usuarios` ·
`Gestao de Cartas` · `Gestao de Albuns` · `Gestao de MarketPlace` ·
`Gestao de Grupos` · `Solicitacoes` · `Configuracoes`

---

## 2. Os 7 problemas (é isso que o professor viu)

1. **6 épicos de produto onde deveria haver 1.** O CromoCard foi fatiado por
   painel (`Público`, `Cliente`, `Administrador`, `Estrutura`, `__CromoCard`).
   Painel não é épico — é Feature.
2. **Cada caso de uso virou uma Feature.** As 45 `CCD0xx` são Features hoje.
   Um caso de uso é uma **User Story** (uma ação do usuário, com critério de
   aceite). Por isso o board tem 55 Features e nenhuma delas tem filho.
3. **28 User Stories órfãs** (#55–#82), sem Parent, invisíveis na árvore.
4. **Épico vazio:** `#47 CromoCard - Painel Administrador` não tem nada abaixo.
5. **Item duplicado:** `#111` e `#112` são ambos `CCD006-Recuperar Senha`.
6. **Nome provisório:** `#185 __CromoCard` (com os dois underscores).
7. **Cerimônias em dois padrões diferentes.** Ver seção 4.

### Achados de numeração (conferir com a equipe)

- **`CCD032` e `CCD033` divergem** entre o board e a planilha `CromoCard 1.xlsx`:

  | Código | No board | Na planilha |
  |---|---|---|
  | CCD032 | Interagir com o Álbum | Buscar por Estado da Carta |
  | CCD033 | Ordenar Coleção | Buscar por Vendedor |

- **`CCD034`–`CCD044` só existem no board** (Buscar Categoria do Álbum, Resetar
  Progresso, Adicionar Carta ao Portfólio, Buscar Categoria do Card,
  Acessibilidade, e os 6 de Grupos).
- **`CCD045`–`CCD066` só existem na planilha** (Chat Pessoal, Perfil,
  Notificações/Favoritos, BackOffice) — **22 casos de uso ainda não estão no
  board.**

> Decidir qual fonte manda **antes** de mexer, senão a renumeração se perde.

---

## 3. A estrutura proposta

### Quantos épicos no final?

**Recomendação: 2.**

```
Epic #5  EXEMPLO                 (do professor, intacto)
Epic #39 CromoCard               (o produto — renomear o #39)
Epic #84 Documentacao - CromoCard (o processo da disciplina)
```

O `#84` guarda sprints, cerimônias, apontamentos, C4/ADR, avaliação 360 — é o
**processo**, não o produto. Misturar isso com as telas é o que embola o
burndown e a leitura do board.

> Se o professor quiser **literalmente um só**, o `#84` vira
> `Feature: Documentação e Processo` dentro do Epic CromoCard. A árvore continua
> válida. Perguntem antes de executar.

### A árvore do produto

```
Epic #39  CromoCard — Plataforma de coleção, comunidade e troca de cartas
│
├── Feature  Painel Público                    (era Epic #39)
├── Feature  Álbuns e Coleção                  (fatia do Epic #43)
├── Feature  Busca e Catálogo de Cartas        (fatia do Epic #43)
├── Feature  Grupos da Comunidade              (#186 + CCD039–044)
├── Feature  Chat Pessoal                      (a criar — CCD045–047)
├── Feature  Perfil e Configurações            (a criar — CCD048–052)
├── Feature  Notificações e Favoritos          (a criar — CCD053–057)
├── Feature  Painel Administrador              (era Epic #47)
├── Feature  Marketplace                       (#187)
├── Feature  Integrações                       (nova; #188 e #189 descem para US)
└── Feature  Estrutura Técnica                 (era Epic #98, com #99 Banco de Dados)
```

Cada `CCD0xx` desce um nível: de **Feature** para **User Story**, filha da
Feature da sua área. As telas (#55–#82) entram como User Story na mesma Feature,
com a tag `tela`.

---

## 4. Cerimônias — o padrão que vocês já criaram

Vocês têm 5 tipos customizados: **Reuniões**, **Cerimônias**, **Daily**,
**Spike**, **Task Spike**. O padrão bom já existe no board (`#89 Sprint 01` e
`#168 Sprint 02`, e o `EXEMPLO` do professor usa o mesmo):

```
[Reuniões]   Sprint 02                    ← o contêiner da sprint
├── [Cerimônias] Planning 15/08/2026      ← o evento
│   ├── [Task] Apontamento Felipe Duarte  ← 1 por pessoa
│   ├── [Task] Apontamento Lucas
│   └── [Task] Apontamento Daniel
├── [Cerimônias] Review Sprint 02
├── [Cerimônias] Retrospectiva Sprint 02
├── [Daily] Daily 19/08
└── [Daily] Daily 20/08
```

**O que corrigir:** o `#190 Cerimonias` é do tipo `Cerimônias` e tem como filho
o `#191 Sprint1`, também `Cerimônias` — invertido, fora do padrão e pendurado no
Epic `#185`. Olhando de perto, os dois estão **vazios**: o `#190` é só um contêiner
sem conteúdo próprio, e a Sprint 01 já existe como `Reuniões #89`, com a Planning e
a Revisão reais dentro. Não há o que migrar — os dois vão para `State = Removed`, e
a Sprint 01 continua sendo o `#89`.

**Regra:** todo bloco de cerimônia mora no `#84 Documentacao`, nunca no épico do
produto.

### Sugestões de tipos (minha recomendação: **não criar mais**)

Vocês já têm o suficiente. Mais tipo = mais atrito pra equipe que está
aprendendo. Em vez de criar, aproveitem:

| Necessidade | Use isto | Em vez de criar |
|---|---|---|
| Review / Retrospectiva | `Cerimônias` com o nome no título | ~~tipo `Review`, tipo `Retro`~~ |
| Impedimento / bloqueio | `Issue` (**já existe** no processo Agile) | ~~tipo `Impedimento`~~ |
| Investigação técnica | `Spike` + `Task Spike` (já existem) | — |
| Defeito | `Bug` (já existe) | — |

O que **vale** padronizar, e não custa tipo novo:

- **Nome da cerimônia:** `<Evento> Sprint NN` → `Planning Sprint 02`,
  `Review Sprint 02`, `Retrospectiva Sprint 02`. Daily fica `Daily DD/MM`.
- **Apontamento:** `Apontamento <Nome>`, sempre `Task`, sempre filha da
  cerimônia. Vocês já fazem — só manter.
- **Iteration Path** correto na cerimônia (o `#89 Sprint 01` está em `Backlog`,
  devia estar em `Sprint 01`).

---

## 5. Mapa de-para — nada se perde

> Nenhum item é excluído. Tudo muda de **tipo** ou de **pai**.

### Épicos

| Hoje | Ação |
|---|---|
| `#5 EXEMPLO` | **Não tocar** |
| `#39 CromoCard - Painel Público` | **Renomear** para `CromoCard — Plataforma de coleção, comunidade e troca de cartas`. Vira o épico único do produto. Criar abaixo dele a Feature `Painel Público` e mover CCD001–006 pra lá. |
| `#43 CromoCard - Painel Cliente` | `Change type` → **Feature**, Parent = `#39`. Depois quebrar: ver abaixo. |
| `#47 CromoCard - Painel Administrador` | `Change type` → **Feature**, Parent = `#39` |
| `#84 Documentacao - CromoCard` | **Mantém como Epic** (processo da disciplina) |
| `#98 CromoCard - Estrutura` | `Change type` → **Feature** `Estrutura Técnica`, Parent = `#39`. O `#99 Banco de Dados` desce de Feature para User Story. |
| `#185 __CromoCard` | Esvaziar: mover `#186`–`#189` para Parent = `#39`. `#190/#191` → `Removed` (ver seção 4). Depois `State = Removed`. |

### As 45 Features CCD → User Story

Todas viram **User Story**. Novo pai:

| Códigos | IDs | Nova Feature |
|---|---|---|
| CCD001–CCD006 | #88, #107–#112 | Painel Público |
| CCD007–CCD022 | #113–#128 | Álbuns e Coleção |
| CCD034–CCD038 | #137–#141 | Álbuns e Coleção |
| CCD023–CCD033 | #156–#166 | Busca e Catálogo de Cartas |
| CCD039–CCD044 | #142–#147 | Grupos da Comunidade |

`#112` é duplicata de `#111` → `State = Removed`.

### As 28 telas órfãs → User Story com tag `tela`

| IDs | Nova Feature |
|---|---|
| #55 Login, #56 Cadastro, #74 Home | Painel Público |
| #57 Dashboard, #58 Meus Albuns, #59 Album, #60 Cadastro de Carta | Álbuns e Coleção |
| #69 Meu Perfil | Perfil e Configurações |
| #72 Notificacoes, #73 Favoritos | Notificações e Favoritos |
| #66 Grupos - Trocas, #67 Listagem grupos, #68 chat/conversas | Grupos da Comunidade |
| #61–#65 Marketplace (5), #70 Minhas Compras, #71 Minhas Vendas | Marketplace |
| #75 Dashboard, #76–#80 Gestao de (5), #81 Solicitacoes, #82 Configuracoes | Painel Administrador |

### Epic #84 — o que fica como está

`#85`, `#87`, `#100`–`#106`, `#195`, `#198`, `#200` (criação das US) ·
`#148` Estrutura de C4 e ADR · `#182` Continuação dos User Story ·
`#202` Pesquisa de Mercado · `#89` Sprint 01 · `#168` Sprint 02
**→ já estão certos, não mexer.**

---

## 6. Convenções (combinar e não variar)

| Item | Padrão | Exemplo |
|---|---|---|
| Epic | Produto ou processo | `CromoCard — Plataforma...` |
| Feature | Área funcional | `Grupos da Comunidade` |
| User Story | `CCD0xx - Verbo + objeto` | `CCD014 - Marcar Carta como Possuo` |
| Task | Ação técnica | `Criar endpoint GET /albuns` |
| Cerimônia | `<Evento> Sprint NN` | `Retrospectiva Sprint 02` |
| Apontamento | `Apontamento <Nome>` | `Apontamento Lucca` |

**Campos obrigatórios na User Story:** `Description` com a narrativa
(*Como &lt;ator&gt; preciso... para...* — já está na planilha),
`Acceptance Criteria` (dos fluxos dos casos de uso), `Iteration Path`, e tag de fase.

**Tags de fase** (da legenda da planilha) — assim o escopo é filtro, não épico:

| Marcador | Tag |
|---|---|
| (sem) | `mvp` |
| `**` | `futuro` |
| `***` | `futuro-marketplace` |

---

## 7. Passo a passo

Fazer em dupla, com o board projetado, **nesta ordem**:

1. **Decidir** as duas dúvidas em aberto: 1 ou 2 épicos (seção 3) e a
   numeração CCD032/033 (seção 2).
2. Renomear `#39` e criar as **11 Features** da seção 3.
3. `Change type` nos épicos `#43`, `#47`, `#98` → Feature, Parent = `#39`.
   *(abrir o item → menu `⋯` → `Change type`)*
4. **Reparentar as 4 Features** do `#185` (#186–#189) para `#39`.
5. `Change type` nas **45 CCD** → User Story, e reparentar pelo mapa da seção 5.
   Dá pra fazer em lote: selecionar várias no backlog → `bulk edit`.
6. Reparentar as **28 telas** (#55–#82) + tag `tela`.
7. `Removed` em `#190` e `#191` (vazios; a Sprint 01 real é o `#89`).
8. `Removed` em `#112` (duplicata) e `#185` (ficou vazio).
9. Criar as User Stories de **CCD045–CCD066** (22 faltando) nas Features
   Chat Pessoal, Perfil, Notificações e Painel Administrador.
10. Conferir em `Boards → Backlogs → Epics` com *Show Parents* ligado: deve ler
    `CromoCard › Feature › User Story › Task`, sem nada órfão.

> **Ordem importa:** reparentar antes de mudar tipo faz o Azure recusar o link
> (Feature não aceita Feature como pai). Sempre `Change type` primeiro.

---

## 8. Roteiro da apresentação (~15 min)

| Tempo | Bloco |
|---|---|
| 3 min | Board atual projetado: 7 épicos, 55 Features sem filho, 28 US órfãs (seções 1 e 2) |
| 2 min | A regra: Epic = produto · Feature = área · User Story = caso de uso · Task = passo técnico |
| 4 min | A proposta: 1 Epic de produto + 11 Features (seção 3) |
| 2 min | Cerimônias: o padrão que já temos, o que corrigir, e por que **não** criar mais tipos (seção 4) |
| 2 min | As duas decisões em aberto — votar na hora (seção 7, passo 1) |
| 2 min | Dividir as 11 Features entre os 6 e executar os passos 2–8 |

**Fechar a reunião com a árvore montada**, mesmo que as stories ainda estejam
sem critério de aceite.

---

## Anexo — Inventário completo lido do board

<details>
<summary>176 work items (clique para abrir)</summary>

### Epic #5 EXEMPLO — do professor, intacto
- Feature #7 Exemplo - Cadastro de novo usuário
  - US #9 Exemplo - Criar conta → Tasks #15, #16, #17 · Bug #33
  - US #10 Exemplo - Confirmar e-mail → Tasks #18, #19, #20 · Bug #28
- Feature #8 Exemplo - Login e recuperação de senha
  - US #11 Exemplo - Entrar na plataforma → Task #29 · Bug #30
  - US #12 Exemplo - Recuperar senha → Task #31 · Bug #32
- Spike #13 Exemplo - Definir a estratégia de autenticação → Task Spike #21, #22
- Reuniões #23 Exemplo - Sprint 1 → Cerimônias #24 · Daily #25, #27

### Epic #39 CromoCard - Painel Público
Features: #88 CCD001 Visualizar Destaques *(Sprint 01)* · #107 CCD002 Buscar Global ·
#108 CCD003 Criar Conta · #109 CCD004 Realizar Login · #110 CCD005 Central de Ajuda FAQ ·
#111 CCD006 Recuperar Senha · **#112 CCD006 Recuperar Senha (duplicata)**

### Epic #43 CromoCard - Painel Cliente
Features (38): #113 CCD007 · #114 CCD008 · #115 CCD009 · #116 CCD010 · #117 CCD011 ·
#118 CCD012 · #119 CCD013 · #120 CCD014 · #121 CCD015 · #122 CCD016 · #123 CCD017 ·
#124 CCD018 · #125 CCD019 · #126 CCD020 · #127 CCD021 · #128 CCD022 · #137 CCD034 ·
#138 CCD035 · #139 CCD036 · #140 CCD037 · #141 CCD038 · #142 CCD039 · #143 CCD040 ·
#144 CCD041 · #145 CCD042 · #146 CCD043 · #147 CCD044 · #156 CCD023 · #157 CCD024 ·
#158 CCD025 · #159 CCD026 · #160 CCD027 · #161 CCD028 · #162 CCD029 · #163 CCD030 ·
#164 CCD031 · #165 CCD032 · #166 CCD033

### Epic #47 CromoCard - Painel Administrador
*(vazio)*

### Epic #84 Documentacao - CromoCard
- US #85 Criar backlog dos caso de uso `Closed` → Task #86
- US #87 Criar User Story Painel Publico `Closed` → Task #129
- US #100–#105 Criar User Story Painel Cliente Partes 01–06 `Closed` → Tasks #130–#135
- US #106 Criar User Story Painel Administrador `Closed` → Task #136
- US #195 Painel Cliente Parte 07 `New` → Task #197
- US #198 Painel Cliente Parte 08 `Closed` → Task #199
- US #200 Criar User Story Painel Vendedor `Closed` → Task #201
- Reuniões #89 Sprint 01 `Closed`
  - Cerimônias #91 Planning 15/08/2026 → Tasks #92, #93, #94, #95, #97
  - Cerimônias #169 Revisão dos User Story → Tasks #170, #171, #172, #173
- Reuniões #168 Sprint 02 `Active`
  - Cerimônias #175 Definição do marketplace → Tasks #176–#181
- Feature #148 Estrutura de C4 e ADR `Active`
  - US #149 Estrutura - C4 → Tasks #154 `Active`, #155 `Closed`
  - US #150 Estrutura - ADR → Tasks #152, #153
- Feature #182 Continuação dos User Story `Active`
  - US #183 US do marketplace e painel do vendedor → Task #184
  - US #193 Distribuição dos novos User Story → Task #194
- Feature #202 Pesquisa de Mercado e aplicações de ferramentas
  - US #203 → Tasks #204–#209

### Epic #98 CromoCard - Estrutura
- Feature #99 Banco de Dados *(Sprint 01)*

### Epic #185 __CromoCard
- Features #186 Grupos de Comunidade · #187 MarketPlace ·
  #188 Integracao com Transportadora · #189 Integracao Gateway Pagamento
- Cerimônias #190 Cerimonias → Cerimônias #191 Sprint1 *(fora do padrão, ambos vazios)*

### Sem pai — 28 User Stories
#55 Login · #56 Cadastro · #57 Dashboard · #58 Meus Albuns · #59 Album ·
#60 Cadastro de Carta · #61 Marketplace - Listagem de Cartas ·
#62 Marketplace - detalhes das cartas · #63 Marketplace - Carrinho ·
#64 Marketplace - Checkout · #65 Marketplace - Meus Anuncios · #66 Grupos - Trocas ·
#67 Grupos - Listagem grupos · #68 Grupo - chat/conversas · #69 Meu Perfil ·
#70 Minhas Compras · #71 Minhas Vendas · #72 Notificacoes · #73 Favoritos · #74 Home ·
#75 Dashboard · #76 Gestao de usuarios · #77 Gestao de Cartas · #78 Gestao de Albuns ·
#79 Gestao de MarketPlace · #80 Gestao de Grupos · #81 Solicitacoes · #82 Configuracoes

</details>


---

## Visualização

`board-cromocard.html` — a árvore completa dos dois cenários num toggle
**Hoje / Proposto**, com as cores de tipo do próprio Azure DevOps e um badge em
cada item mostrando de onde ele veio. Abrir no navegador.
