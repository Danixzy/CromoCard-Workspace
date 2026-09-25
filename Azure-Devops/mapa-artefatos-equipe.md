# Mapa de artefatos por pessoa — board CromoCard

> Leitura real do board em **24/09/2026** (org `CromoCard`, projeto `CromoCard`),
> via API REST. **246 work items** — eram 176 em 28/08.
> Nada foi alterado no Azure. Isto é só a leitura.

**Sprints no board:** Sprint 01 · Sprint 02 · Sprint 03 · Sprint 04

---

## 1. Quem postou o quê

| Pessoa | Itens | Epic | Feature | User Story | Task | Cerimônia/Reunião/Daily | Bug | Spike | Período |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| **Felipe Consulim** | 114 | 2 | 12 | 31 | 60 | 9 | — | — | 14/08 → 18/09 |
| **lucas oliveira lima** | 79 | — | 5 | 48 | 25 | 1 | — | — | 13/08 → 23/09 |
| **daniel andrade** | 38 | — | 2 | 15 | 9 | 5 | 4 | 3 | 13/08 → 09/09 |
| **Felipe Broetto Araujo** | 11 | — | — | 10 | 1 | — | — | — | 17/08 → 09/09 |
| **Gabriel Nascimento** | 4 | — | — | — | 3 | 1 | — | — | 17/09 |
| **Lucca Rocha** | **0** | — | — | — | — | — | — | — | — |

Dois terços do board (193 de 246) saíram de duas pessoas: Felipe Consulim e Lucas.

**Leituras que o número bruto esconde:**

- **Daniel:** dos 38 itens, **25 são os `Exemplo -` do professor** — o bloco-modelo
  (Epic, Features, US, Tasks, Bugs, Spike, Daily) foi cadastrado pela sua conta.
  Produção própria: **13 itens**, as User Stories `CCD023`–`CCD033` (busca e
  catálogo), a cerimônia `#243 Pesquisa e Estudo` e um apontamento.
- **Lucca Rocha** não criou nenhum item, mas tem **13 atribuídos** e aparece em
  **7 apontamentos**. Trabalha no board, só não cadastra.
- **Gabriel** entrou tarde: os 4 itens são todos de 17/09, todos `Closed`.

## 2. Quem é responsável (Assigned To)

| Pessoa | Itens atribuídos |
|---|---:|
| — **sem responsável** | **76** |
| daniel andrade | 52 |
| lucas oliveira lima | 42 |
| Felipe Consulim | 21 |
| Felipe Broetto Araujo | 20 |
| Gabriel Nascimento | 20 |
| Lucca Rocha | 13 |
| `gabriel.naascimento18@gmail.com` | 2 |

Criar e ser responsável divergem bastante: Felipe Consulim criou 114 e responde
por 21; Daniel criou 38 e responde por 52.

## 3. Estado e distribuição

| Estado | Itens | | Iteration Path | Itens |
|---|---:|---|---|---:|
| New | 137 | | Backlog | 88 |
| Closed | 99 | | `CromoCard` (raiz) | 51 |
| Active | 10 | | Sprint 02 | 44 |
| | | | Sprint 01 | 41 |
| | | | Sprint 03 | 16 |
| | | | Sprint 04 | 6 |

**139 dos 246 itens (56%) estão fora de qualquer sprint** — em `Backlog` ou na
raiz `CromoCard`. O burndown das sprints enxerga menos da metade do board.

## 4. Cerimônias

Todas penduradas em `#89 Reuniões` (filho do Epic #84), exceto as do bloco
`Exemplo` e o `#190`.

| Cerimônia | ID | Sprint | Apontamentos | Criada por |
|---|---|---|---:|---|
| Planning 15/08/2026 | #91 | Sprint 01 | 5 | Felipe Consulim |
| Revisão dos User Story | #169 | Sprint 01 | 4 | Felipe Consulim |
| Definição do marketplace | #175 | Sprint 02 | 5 | Felipe Consulim |
| Reunião | #211 | Sprint 02 | 6 | Felipe Consulim |
| Planning Sprint 03 | #235 | Sprint 03 | 6 | Felipe Consulim |
| Pesquisa e Estudo | #243 | Backlog | 5 | daniel andrade |
| Revisão de Diagrama de Atividade | #250 | Backlog | 3 | Gabriel Nascimento |
| Planning Sprint 04 | #256 | Sprint 04 | 5 | Felipe Consulim |
| Revisão dos Diagramas | #287 | Backlog | 4 | lucas oliveira lima |

São **43 apontamentos**. A presença por nome: Felipe Duarte 8 · Lucas 8 ·
Lucca 7 · Gabriel 7 · Daniel 6 · Felipe Broetto 4.

---

## 5. O que mudou desde 28/08

**79 itens novos:** Felipe Consulim 39 · Lucas 33 · Gabriel 4 · Daniel 2 ·
Felipe Broetto 1.

A reorganização proposta em `organizacao-board-cromocard.md` foi **executada pela
metade**:

✅ **Feito** — os 7 épicos viraram 2. `#5 EXEMPLO`, `#39`, `#43`, `#47` e `#185`
saíram do board. As 45 Features `CCD0xx` viraram User Stories (o board tem 104 US
hoje, contra 49 antes, e 19 Features contra 55).

❌ **Não feito** — os 6 pontos da seção 7 abaixo.

## 6. Como a árvore está hoje

```
Epic #84  Documentacao - CromoCard          (13 filhos)
├── Feature #148 Estrutura de C4 e ADR      Closed
├── Feature #182 Continuação dos User Story Closed
├── Feature #202 Pesquisa de Mercado        Closed
├── Feature #210 Criação Dos Diagramas      Active
├── Feature #228 Especificações de casos de uso  Closed
├── Feature #232 organização da matriz CSD
├── Feature #263 Design do Sistema
├── Feature #269 Arquitetura e documentação técnica
├── Reuniões #89 → as 9 cerimônias
├── Feature #229 CromoCard - Painel Cliente        ← 38 User Stories
├── Feature #230 CromoCard - Painel Administrador  ← vazia
└── Feature #231 CromoCard - Painel Público        ← 6 User Stories

Epic #98  CromoCard - Estrutura             (2 filhos)
├── Feature #99  Banco de Dados             ← vazia
└── Feature #277 Fundação de infraestrutura e entrega contínua

Órfãos (37 itens, sem Parent)
├── 28 User Stories  #55–#82   (o inventário de telas)
├── Feature #186 Grupos de Comunidade        ← vazia
├── Feature #187 MarketPlace                 ← vazia
├── Feature #188 Integracao com Transportadora ← vazia
├── Feature #189 Integracao Gateway Pagamento  ← vazia
├── Cerimônias #190 Cerimonias → #191 Sprint1
└── Feature #7, #8 · Spike #13 · Reuniões #23   (restos do EXEMPLO)
```

## 7. Os 7 problemas de hoje

1. **Não existe épico de produto.** O CromoCard inteiro — `#229 Painel Cliente`
   (38 US), `#230 Painel Administrador`, `#231 Painel Público` — está pendurado
   no `#84 Documentacao - CromoCard`, que é o épico de **processo** da disciplina.
   Produto e processo ficaram no mesmo balde, que é exatamente o que a
   reorganização queria separar. **Falta criar o Epic do produto** e mover essas
   três Features para lá.
2. **As 28 User Stories órfãs `#55`–`#82` continuam órfãs**, sem Parent, um mês
   depois. São as telas do produto.
3. **4 Features órfãs e vazias:** `#186` Grupos, `#187` MarketPlace, `#188`
   Transportadora, `#189` Gateway. Eram filhas do Epic `#185`, que foi removido —
   ficaram soltas em vez de serem reparentadas.
4. **`#190 Cerimonias` → `#191 Sprint1` continuam no board**, vazios e fora do
   padrão, apesar de marcados para `Removed`.
5. **Duas Features vazias:** `#230 Painel Administrador` e `#99 Banco de Dados`.
6. **76 itens (31%) sem responsável**, incluindo 33 User Stories e 15 Tasks.
7. **Restos do EXEMPLO soltos:** removido o Epic `#5`, sobraram órfãos `#7`, `#8`
   (Features), `#13` (Spike) e `#23` (Reuniões) com seus filhos.

### Inconsistências menores

- **Identidade duplicada:** `Gabriel Nascimento` e `gabriel.naascimento18@gmail.com`
  são a mesma pessoa, com 2 itens presos na segunda.
- **Nomes de apontamento sem padrão:** `Apontamento Daniel` vs
  `Apontamento Daniel 08/09` · `Felipe Broetto` vs `Felipe Broetto Araujo` ·
  `Felipe Duarte` vs `Duarte`. Isso quebra a contagem de presença por pessoa.
- **Cerimônias sem sprint:** `#243`, `#250` e `#287` estão em `Backlog`.

---

## Anexo — inventário completo por pessoa

<details>
<summary>246 work items (clique para abrir)</summary>


### Felipe Consulim — 114 itens

| ID | Tipo | Título | Estado | Responsável | Criado |
|---|---|---|---|---|---|
| #84 | Epic | Documentacao - CromoCard | Active | — | 2026-08-14 |
| #85 | User Story | Área do PO | Active | — | 2026-08-15 |
| #86 | Task | Criar backlog dos caso de uso | Closed | Felipe Consulim | 2026-08-15 |
| #87 | User Story | Criar User Story Painel Publico | Closed | Felipe Broetto Araujo | 2026-08-15 |
| #88 | User Story | CCD001-Visualizar Destaques | New | Felipe Broetto Araujo | 2026-08-15 |
| #89 | Reuniões | Reuniões | Active | — | 2026-08-15 |
| #91 | Cerimônias | Planning 15/08/2026 | Closed | — | 2026-08-15 |
| #92 | Task | Apontamento Felipe Duarte | Closed | Felipe Consulim | 2026-08-15 |
| #93 | Task | Apontamento Felipe Broetto | Closed | Felipe Consulim | 2026-08-15 |
| #94 | Task | Apontamento Lucas | Closed | lucas oliveira lima | 2026-08-15 |
| #95 | Task | Apontamento Lucca | Closed | Lucca Rocha | 2026-08-15 |
| #97 | Task | Apontamento Daniel | Closed | daniel andrade | 2026-08-15 |
| #98 | Epic | CromoCard - Estrutura | New | — | 2026-08-15 |
| #99 | Feature | Banco de Dados | New | — | 2026-08-15 |
| #100 | User Story | Criar User Story Painel Cliente Parte 01 | Closed | Felipe Broetto Araujo | 2026-08-16 |
| #101 | User Story | Criar User Story Painel Cliente Parte 02 | Closed | Felipe Consulim | 2026-08-16 |
| #102 | User Story | Criar User Story Painel Cliente Parte 03 | Closed | daniel andrade | 2026-08-16 |
| #103 | User Story | Criar User Story Painel Cliente Parte 04 | Closed | lucas oliveira lima | 2026-08-16 |
| #104 | User Story | Criar User Story Painel Cliente Parte 05 | Closed | Lucca Rocha | 2026-08-16 |
| #105 | User Story | Criar User Story Painel Cliente Parte 06 | Closed | gabriel.naascimento18@gmail.com | 2026-08-16 |
| #106 | User Story | Criar User Story Painel Administrador | Closed | gabriel.naascimento18@gmail.com | 2026-08-16 |
| #118 | User Story | CCD012 -Compartilhar Coleção | New | — | 2026-08-18 |
| #119 | User Story | CCD013 -Visualizar Cartas | New | — | 2026-08-18 |
| #120 | User Story | CCD014 -Marcar Carta como Possuo | New | — | 2026-08-18 |
| #121 | User Story | CCD015 -Marcar Carta como Faltante | New | — | 2026-08-18 |
| #122 | User Story | CCD016 -Marcar Carta Repetida | New | — | 2026-08-18 |
| #123 | User Story | CCD017 -Adicionar Quantidade | New | — | 2026-08-18 |
| #124 | User Story | CCD018 -Remover Carta | New | — | 2026-08-18 |
| #125 | User Story | CCD019 -Visualizar Progresso | New | — | 2026-08-18 |
| #126 | User Story | CCD020 -Compartilhar Progresso | New | — | 2026-08-18 |
| #127 | User Story | CCD021 -Pesquisar Carta | New | — | 2026-08-18 |
| #128 | User Story | CCD022 -Adicionar Carta | New | — | 2026-08-18 |
| #129 | Task | Criar User Story Painel Publico | Closed | Felipe Broetto Araujo | 2026-08-18 |
| #130 | Task | Criar User Story Painel Cliente Parte 01 | Closed | Felipe Broetto Araujo | 2026-08-18 |
| #131 | Task | Criar User Story Painel Cliente Parte 02 | Closed | Felipe Consulim | 2026-08-18 |
| #132 | Task | Criar User Story Painel Cliente Parte 03 | Closed | daniel andrade | 2026-08-18 |
| #133 | Task | Criar User Story Painel Cliente Parte 04 | Closed | lucas oliveira lima | 2026-08-18 |
| #134 | Task | Criar User Story Painel Cliente 05 | Closed | Lucca Rocha | 2026-08-18 |
| #135 | Task | Criar User Story Painel Cliente Parte 06 | Closed | Gabriel Nascimento | 2026-08-18 |
| #136 | Task | Criar User Story Painel Administrador | Closed | Gabriel Nascimento | 2026-08-18 |
| #169 | Cerimônias | Revisão dos User Story | Closed | — | 2026-08-20 |
| #170 | Task | Apontamento Felipe Duarte | Closed | Felipe Consulim | 2026-08-20 |
| #171 | Task | Apontamento Lucas | Closed | lucas oliveira lima | 2026-08-20 |
| #172 | Task | Apontamento Daniel | Closed | daniel andrade | 2026-08-20 |
| #173 | Task | Apontamento Lucca | Closed | Lucca Rocha | 2026-08-20 |
| #175 | Cerimônias | Definição  do marketplace | Closed | — | 2026-08-22 |
| #176 | Task | Apontamento Felipe Duarte | Closed | Felipe Consulim | 2026-08-22 |
| #177 | Task | Apontamento Lucas | Closed | lucas oliveira lima | 2026-08-22 |
| #178 | Task | Apontamento Gabriel | Closed | Gabriel Nascimento | 2026-08-22 |
| #179 | Task | Apontamento Felipe Broetto | Closed | Felipe Broetto Araujo | 2026-08-22 |
| #181 | Task | Apontamento Lucca | Closed | Lucca Rocha | 2026-08-22 |
| #182 | Feature | Continuação dos User Story | Closed | — | 2026-08-22 |
| #183 | User Story | Criação do User Story referente ao marketplace e o painel do | Closed | Gabriel Nascimento | 2026-08-22 |
| #184 | Task | Criação do User Story referente ao marketplace e o painel do | Closed | Gabriel Nascimento | 2026-08-22 |
| #186 | Feature | Grupos de Comunidade | New | — | 2026-08-26 |
| #187 | Feature | MarketPlace | New | — | 2026-08-26 |
| #188 | Feature | Integracao com Transportadora | New | — | 2026-08-26 |
| #189 | Feature | Integracao Gateway Pagamento | New | — | 2026-08-26 |
| #190 | Cerimônias | Cerimonias | New | — | 2026-08-26 |
| #191 | Cerimônias | Sprint1 | New | — | 2026-08-26 |
| #193 | User Story | Distribuição dos novos User Story | Closed | Felipe Consulim | 2026-08-27 |
| #194 | Task | Distribuição dos novos User Story | Closed | Felipe Consulim | 2026-08-27 |
| #195 | User Story | Criar User Story Painel Cliente Parte 07 | Closed | Gabriel Nascimento | 2026-08-27 |
| #197 | Task | Criar User Story Painel Cliente Parte 07 | Closed | Gabriel Nascimento | 2026-08-27 |
| #198 | User Story | Criar User Story Painel Cliente Parte 08 | Closed | Felipe Consulim | 2026-08-27 |
| #199 | Task | Criar User Story Painel Cliente Parte 08 | Closed | Felipe Consulim | 2026-08-27 |
| #200 | User Story | Criar User Story Painel Vendedor | Closed | Felipe Consulim | 2026-08-27 |
| #201 | Task | Criar User Story Painel Vendedor | Closed | Felipe Consulim | 2026-08-27 |
| #202 | Feature | Pesquisa de Mercado e aplicações de ferramentas | Closed | — | 2026-08-28 |
| #203 | User Story | Atividade de Pesquisa de Mercado e aplicações de ferramentas | Closed | — | 2026-08-28 |
| #204 | Task | Criação Felipe Duarte | Closed | Felipe Consulim | 2026-08-28 |
| #205 | Task | Criação Felipe Broetto | Closed | — | 2026-08-28 |
| #206 | Task | Criação Lucas | Closed | lucas oliveira lima | 2026-08-28 |
| #207 | Task | Criação Gabriel | Closed | Gabriel Nascimento | 2026-08-28 |
| #208 | Task | Criação Lucca | Closed | Lucca Rocha | 2026-08-28 |
| #210 | Feature | Criação Dos Diagramas | Active | — | 2026-08-29 |
| #211 | Cerimônias | Reunião | Closed | — | 2026-08-29 |
| #212 | User Story | Driagrama de Entidade (DER) | Closed | — | 2026-08-29 |
| #213 | Task | Apontamento Felipe Duarte | Closed | Felipe Consulim | 2026-08-29 |
| #214 | Task | Apontamento Felipe Broetto | Closed | Felipe Broetto Araujo | 2026-08-29 |
| #215 | Task | Apontamento Lucca | Closed | Lucca Rocha | 2026-08-29 |
| #216 | Task | Apontamento Lucas | Closed | lucas oliveira lima | 2026-08-29 |
| #217 | Task | Apontamento Daniel | Closed | daniel andrade | 2026-08-29 |
| #218 | Task | Apontamento Gabriel | Closed | Gabriel Nascimento | 2026-08-29 |
| #220 | User Story | Diagrama Caso de Uso | Active | — | 2026-08-29 |
| #221 | User Story | Diagrama de Classes | Closed | — | 2026-08-29 |
| #222 | Task | Criar diagrama de entidades (DER) | Closed | daniel andrade | 2026-08-29 |
| #223 | Task | Criar diagrama de entidades (DER) | Closed | Felipe Consulim | 2026-08-29 |
| #224 | Task | Criar Diagrama de Casos De Uso 2.0 | Active | Felipe Broetto Araujo | 2026-08-29 |
| #225 | Task | Criar Diagrama de Casos De Uso 1.0 | Closed | lucas oliveira lima | 2026-08-29 |
| #226 | Task | Criar diagrama de classes | Closed | Gabriel Nascimento | 2026-08-29 |
| #227 | Task | Criar diagrama de classes | Closed | Lucca Rocha | 2026-08-29 |
| #229 | Feature | CromoCard - Painel Cliente | New | — | 2026-09-02 |
| #230 | Feature | CromoCard - Painel Administrador | New | — | 2026-09-02 |
| #231 | Feature | CromoCard - Painel Público | New | — | 2026-09-02 |
| #232 | Feature | organização da matriz CSD | New | Gabriel Nascimento | 2026-09-04 |
| #233 | User Story | Matriz CSD | New | Gabriel Nascimento | 2026-09-04 |
| #234 | Task | Criar Matriz CSD | New | Gabriel Nascimento | 2026-09-04 |
| #235 | Cerimônias | Planning Sprint 03 | Closed | — | 2026-09-04 |
| #236 | Task | Apontamento Felipe Duarte | Closed | Felipe Consulim | 2026-09-04 |
| #237 | Task | Apontamento Felipe Broetto | Closed | Felipe Broetto Araujo | 2026-09-04 |
| #238 | Task | Apontamento Lucas | Closed | lucas oliveira lima | 2026-09-04 |
| #239 | Task | Apontamento Lucca | Closed | Lucca Rocha | 2026-09-04 |
| #240 | Task | Apontamento Gabriel | Closed | Gabriel Nascimento | 2026-09-04 |
| #241 | Task | Apontamento Daniel | Closed | daniel andrade | 2026-09-04 |
| #246 | Task | Apontamento Felipe Duarte | Active | Felipe Consulim | 2026-09-09 |
| #254 | Task | Apontamento Lucas | New | — | 2026-09-18 |
| #255 | Task | Apontamento Gabriel | New | — | 2026-09-18 |
| #256 | Cerimônias | Planning Sprint 04 | Active | — | 2026-09-18 |
| #257 | Task | Apontamento Felipe Duarte | Closed | — | 2026-09-18 |
| #259 | Task | Apontamento Lucas | Closed | lucas oliveira lima | 2026-09-18 |
| #260 | Task | Apontamento Gabriel | Closed | Gabriel Nascimento | 2026-09-18 |
| #261 | Task | Apontamento Daniel | Closed | daniel andrade | 2026-09-18 |
| #262 | Task | Apontamento Lucca | Closed | — | 2026-09-18 |

### lucas oliveira lima — 79 itens

| ID | Tipo | Título | Estado | Responsável | Criado |
|---|---|---|---|---|---|
| #55 | User Story | Login | New | lucas oliveira lima | 2026-08-13 |
| #56 | User Story | Cadastro | New | lucas oliveira lima | 2026-08-13 |
| #57 | User Story | Dashboard | New | lucas oliveira lima | 2026-08-14 |
| #58 | User Story | Meus Albuns | New | lucas oliveira lima | 2026-08-14 |
| #59 | User Story | Album | New | lucas oliveira lima | 2026-08-14 |
| #60 | User Story | Cadastro de Carta | New | lucas oliveira lima | 2026-08-14 |
| #61 | User Story | Marketplace - Listagem de Cartas | New | lucas oliveira lima | 2026-08-14 |
| #62 | User Story | Marketplace - detalhes das cartas | New | lucas oliveira lima | 2026-08-14 |
| #63 | User Story | Marketplace - Carrinho | New | — | 2026-08-14 |
| #64 | User Story | Marketplace - Checkout | New | lucas oliveira lima | 2026-08-14 |
| #65 | User Story | Marketplace - Meus Anuncios | New | lucas oliveira lima | 2026-08-14 |
| #66 | User Story | Grupos - Trocas | New | lucas oliveira lima | 2026-08-14 |
| #67 | User Story | Grupos - Listagem grupos | New | lucas oliveira lima | 2026-08-14 |
| #68 | User Story | Grupo - chat/conversas | New | lucas oliveira lima | 2026-08-14 |
| #69 | User Story | Meu Perfil | New | — | 2026-08-14 |
| #70 | User Story | Minhas Compras | New | lucas oliveira lima | 2026-08-14 |
| #71 | User Story | Minhas Vendas | New | — | 2026-08-14 |
| #72 | User Story | Notificacoes | New | — | 2026-08-14 |
| #73 | User Story | Favoritos | New | — | 2026-08-14 |
| #74 | User Story | Home | New | — | 2026-08-14 |
| #75 | User Story | Dashboard | New | lucas oliveira lima | 2026-08-14 |
| #76 | User Story | Gestao de usuarios | New | — | 2026-08-14 |
| #77 | User Story | Gestao de Cartas | New | — | 2026-08-14 |
| #78 | User Story | Gestao de Albuns | New | — | 2026-08-14 |
| #79 | User Story | Gestao de MarketPlace | New | — | 2026-08-14 |
| #80 | User Story | Gestao de Grupos | New | — | 2026-08-14 |
| #81 | User Story | Solicitacoes | New | — | 2026-08-14 |
| #82 | User Story | Configuracoes | New | — | 2026-08-14 |
| #137 | User Story | CCD034 - Buscar Categoria do Álbum | New | lucas oliveira lima | 2026-08-18 |
| #138 | User Story | CCD035 - Resetar Progresso do Álbum | New | lucas oliveira lima | 2026-08-18 |
| #139 | User Story | CCD036 - Adicionar Carta ao Portfólio | New | lucas oliveira lima | 2026-08-18 |
| #140 | User Story | CCD037 - Buscar Categoria do Card | New | lucas oliveira lima | 2026-08-18 |
| #141 | User Story | CCD038 - Acessibilidade | New | lucas oliveira lima | 2026-08-18 |
| #142 | User Story | CCD039 - Explorar e Entrar em Grupos | New | lucas oliveira lima | 2026-08-18 |
| #143 | User Story | CCD040 - Denunciar Mensagem no Grupo | New | lucas oliveira lima | 2026-08-18 |
| #144 | User Story | CCD041 - Silenciar Notificações de Grupo | New | lucas oliveira lima | 2026-08-18 |
| #145 | User Story | CCD042 - Pesquisar no Histórico do Grupo | New | lucas oliveira lima | 2026-08-18 |
| #146 | User Story | CCD043 - Criar e Administrar Grupo | New | lucas oliveira lima | 2026-08-18 |
| #147 | User Story | CCD044 - Interagir no Chat do Grupo | New | lucas oliveira lima | 2026-08-18 |
| #148 | Feature | Estrutura de C4 e ADR | Closed | — | 2026-08-18 |
| #149 | User Story | Estrutura - C4 | Closed | — | 2026-08-18 |
| #150 | User Story | Estrutura - ADR | Closed | — | 2026-08-18 |
| #152 | Task | Criacao ADR Felipe Duarte | Closed | Felipe Consulim | 2026-08-18 |
| #153 | Task | Criacao ADR Lucas | Closed | lucas oliveira lima | 2026-08-18 |
| #154 | Task | Criacao C4 Lucca | Closed | Lucca Rocha | 2026-08-18 |
| #155 | Task | Criacao C4 Daniel | Closed | daniel andrade | 2026-08-18 |
| #228 | Feature | Especificações de casos de uso | Closed | — | 2026-08-31 |
| #247 | User Story | Diagrama de Atividades | Closed | lucas oliveira lima | 2026-09-12 |
| #248 | Task | Estudo sobre diagrama de atividades | Closed | lucas oliveira lima | 2026-09-12 |
| #249 | Task | Criação do Diagrama | Closed | lucas oliveira lima | 2026-09-12 |
| #263 | Feature | Design do Sistema | New | Gabriel Nascimento | 2026-09-19 |
| #264 | User Story | Apresentação do Sistema para clientes e avaliadores | New | Lucca Rocha | 2026-09-19 |
| #265 | Task | Criação dos Slides | New | Lucca Rocha | 2026-09-19 |
| #266 | User Story | Identidade visual e protótipo de telas no Figma | New | Gabriel Nascimento | 2026-09-19 |
| #267 | Task | Protótipo de telas no Figma | New | Gabriel Nascimento | 2026-09-19 |
| #268 | Task | Identidade Visual | New | Gabriel Nascimento | 2026-09-19 |
| #269 | Feature | Arquitetura e documentação técnica | New | — | 2026-09-19 |
| #270 | User Story | Documentação das decisões de arquitetura (ADR) | New | — | 2026-09-19 |
| #271 | User Story | Revisão da documentação de Diagrama de Classes e DER | New | — | 2026-09-19 |
| #272 | Task | Levantar decisões arquiteturais já tomadas | New | — | 2026-09-19 |
| #273 | Task | Redigir as ADRs iniciais | New | — | 2026-09-19 |
| #274 | Task | Publicar/versionar ADRs no repositório | New | — | 2026-09-19 |
| #275 | Task | Revisar Diagrama de Classes | New | — | 2026-09-19 |
| #276 | Task | Revisar DER | New | — | 2026-09-19 |
| #277 | Feature | Fundação de infraestrutura e entrega contínua | New | — | 2026-09-19 |
| #278 | User Story | Criação do repositório do projeto no GitHub | New | daniel andrade | 2026-09-19 |
| #279 | Task | Criar repositório e definir visibilidade | New | daniel andrade | 2026-09-19 |
| #280 | Task | Definir estratégia de branches | New | daniel andrade | 2026-09-19 |
| #281 | User Story | Arquitetura de servidor e pipeline de CI/CD | New | lucas oliveira lima | 2026-09-19 |
| #282 | Task | Definir topologia de ambientes e requisitos do servidor | New | — | 2026-09-19 |
| #283 | Task | Provisionar servidor/infraestrutura de hospedagem | New | — | 2026-09-19 |
| #284 | Task | Configurar pipeline de build | New | — | 2026-09-19 |
| #285 | Task | Configurar pipeline de release/deploy | New | — | 2026-09-19 |
| #286 | Task | Configurar gestão de variáveis e segredos | New | — | 2026-09-19 |
| #287 | Cerimônias | Revisão dos Diagramas | Closed | — | 2026-09-23 |
| #288 | Task | Apontamento Lucas | Closed | lucas oliveira lima | 2026-09-23 |
| #289 | Task | Apontamento Lucca | Closed | Lucca Rocha | 2026-09-23 |
| #290 | Task | Apontamento Duarte | Closed | Felipe Consulim | 2026-09-23 |
| #291 | Task | Apontamento Gabriel | Closed | daniel andrade | 2026-09-23 |

### daniel andrade — 38 itens

| ID | Tipo | Título | Estado | Responsável | Criado |
|---|---|---|---|---|---|
| #7 | Feature | Exemplo - Cadastro de novo usuário | New | daniel andrade | 2026-08-13 |
| #8 | Feature | Exemplo - Login e recuperação de senha | New | daniel andrade | 2026-08-13 |
| #9 | User Story | Exemplo - Criar conta | New | daniel andrade | 2026-08-13 |
| #10 | User Story | Exemplo - Confirmar e-mail | New | daniel andrade | 2026-08-13 |
| #11 | User Story | Exemplo - Entrar na plataforma | New | daniel andrade | 2026-08-13 |
| #12 | User Story | Exemplo - Recuperar senha | New | daniel andrade | 2026-08-13 |
| #13 | Spike | Exemplo - Definir a estratégia de autenticação | New | daniel andrade | 2026-08-13 |
| #15 | Task | Exemplo - Desenhar a tela de cadastro | New | daniel andrade | 2026-08-13 |
| #16 | Task | Exemplo - Criar migration da tabela usuarios | New | daniel andrade | 2026-08-13 |
| #17 | Task | Exemplo - Desenvolver endpoint POST /api/usuarios | New | daniel andrade | 2026-08-13 |
| #18 | Task | Exemplo - Desenhar a tela de login | New | daniel andrade | 2026-08-13 |
| #19 | Task | Exemplo - Desenvolver endpoint POST /api/sessoes | New | daniel andrade | 2026-08-13 |
| #20 | Task | Exemplo - Implementar contagem de tentativas e bloqueio temp | New | daniel andrade | 2026-08-13 |
| #21 | Task Spike | Exemplo - Comparar JWT, sessão no servidor e provedor extern | New | daniel andrade | 2026-08-13 |
| #22 | Task Spike | Exemplo - Montar POC da opção mais promissora | New | daniel andrade | 2026-08-13 |
| #23 | Reuniões | Exemplo - Sprint 1 | New | daniel andrade | 2026-08-13 |
| #24 | Cerimônias | Exemplo - Planning Sprint 1 | New | daniel andrade | 2026-08-13 |
| #25 | Daily | Exemplo - Daily 19/08 | New | daniel andrade | 2026-08-13 |
| #27 | Daily | Exemplo - Daily 20/08 | New | daniel andrade | 2026-08-13 |
| #28 | Bug | Exemplo - E-mail de confirmação não chega para domínios corp | New | daniel andrade | 2026-08-13 |
| #29 | Task | Exemplo - Documentar o endpoint no portal de APIs | New | daniel andrade | 2026-08-13 |
| #30 | Bug | Exemplo - Bug 2 | New | daniel andrade | 2026-08-13 |
| #31 | Task | Exemplo - Revisar o pull request do cadastro | New | daniel andrade | 2026-08-13 |
| #32 | Bug | Exemplo - Bug 3 | New | daniel andrade | 2026-08-13 |
| #33 | Bug | Exemplo - Bug 4 | New | daniel andrade | 2026-08-13 |
| #156 | User Story | CCD023 - Solicitar Cadastro da Carta | New | daniel andrade | 2026-08-20 |
| #157 | User Story | CCD024 - Buscar por Nome | New | daniel andrade | 2026-08-20 |
| #158 | User Story | CCD025 - Buscar por Número | New | daniel andrade | 2026-08-20 |
| #159 | User Story | CCD026 - Buscar por Coleção | New | daniel andrade | 2026-08-20 |
| #160 | User Story | CCD027 - Buscar por Categoria | New | daniel andrade | 2026-08-20 |
| #161 | User Story | CCD028 - Buscar por Raridade | New | daniel andrade | 2026-08-20 |
| #162 | User Story | CCD029 - Buscar por Idioma | New | daniel andrade | 2026-08-20 |
| #163 | User Story | CCD030 - Visualizar Detalhes | New | daniel andrade | 2026-08-20 |
| #164 | User Story | CCD031 - Visualizar Informações da Carta | New | daniel andrade | 2026-08-20 |
| #165 | User Story | CCD032 - Interagir com o Álbum | New | daniel andrade | 2026-08-20 |
| #166 | User Story | CCD033 - Ordenar Coleção | New | daniel andrade | 2026-08-20 |
| #243 | Cerimônias | Pesquisa e Estudo | Active | daniel andrade | 2026-09-09 |
| #244 | Task | Apontamento Daniel 08/09 | Closed | daniel andrade | 2026-09-09 |

### Felipe Broetto Araujo — 11 itens

| ID | Tipo | Título | Estado | Responsável | Criado |
|---|---|---|---|---|---|
| #107 | User Story | CCD002-Buscar Global | New | Felipe Broetto Araujo | 2026-08-17 |
| #108 | User Story | CCD003-Criar Conta | New | Felipe Broetto Araujo | 2026-08-17 |
| #109 | User Story | CCD004-Realizar Login | New | Felipe Broetto Araujo | 2026-08-17 |
| #110 | User Story | CCD005-Central de Ajuda FAQ | New | Felipe Broetto Araujo | 2026-08-17 |
| #111 | User Story | CCD006-Recuperar Senha | New | Felipe Broetto Araujo | 2026-08-17 |
| #113 | User Story | CCD007-Visualizar Resumo da Coleção | New | Felipe Broetto Araujo | 2026-08-18 |
| #114 | User Story | CCD008-Listar Álbum | New | Felipe Broetto Araujo | 2026-08-18 |
| #115 | User Story | CCD009-Buscar Álbum | New | Felipe Broetto Araujo | 2026-08-18 |
| #116 | User Story | CCD010-Solicitar Álbum | New | Felipe Broetto Araujo | 2026-08-18 |
| #117 | User Story | CCD011-Remover Álbum | New | Felipe Broetto Araujo | 2026-08-18 |
| #245 | Task | Apontamento Felipe Broetto Araujo | Active | Felipe Broetto Araujo | 2026-09-09 |

### Gabriel Nascimento — 4 itens

| ID | Tipo | Título | Estado | Responsável | Criado |
|---|---|---|---|---|---|
| #250 | Cerimônias | Revisão de Digrama de Atividade | Closed | — | 2026-09-17 |
| #251 | Task | Apontamento Felipe Duarte | Closed | Felipe Consulim | 2026-09-17 |
| #252 | Task | Apontamento Daniel | Closed | daniel andrade | 2026-09-17 |
| #253 | Task | Apontamento Gabriel | Closed | Gabriel Nascimento | 2026-09-17 |

</details>
