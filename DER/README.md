# DER - CromoCard (Sistema de Gestao de Cartas Colecionaveis)

Modelo de dados derivado dos **Casos de Uso / User Stories** em `../Casos-De-Uso/`
e alinhado aos diagramas C4 em `../Diagramas-C4/` (API Node.js + Prisma + PostgreSQL).

**43 entidades organizadas em 8 modulos.** Os 3 diagramas existem nos dois formatos.

## Estrutura

```
DER/
├── puml/                              -> PlantUML  (plantuml.com / VS Code)
│   ├── 01-diagrama-entidades.puml
│   ├── 02-diagrama-relacionamentos.puml
│   └── 03-der-completo.puml
├── dbdiagram.io/                      -> DBML      (dbdiagram.io/d)
│   ├── 01-diagrama-entidades.dbml
│   ├── 02-diagrama-relacionamentos.dbml
│   └── 03-der-completo.dbml
└── chartdb/                           -> DDL SQL   (app.chartdb.io e outros)
    ├── schema-cromocard.sql
    └── schema-cromocard-sem-enums.sql
```

## Pasta `chartdb/` (DDL SQL)

O ChartDB nao le DBML - ele importa **script SQL**. Os dois arquivos foram
gerados a partir de `dbdiagram.io/03-der-completo.dbml`, entao nao divergem do
modelo: 43 tabelas, 76 chaves estrangeiras, 22 enums.

1. Abra <https://app.chartdb.io>.
2. Escolha importar a partir de **script SQL** e selecione o dialeto **PostgreSQL**.
3. Cole `schema-cromocard.sql` inteiro.
4. Se a ferramenta reclamar dos `CREATE TYPE ... AS ENUM`, use
   `schema-cromocard-sem-enums.sql`: as colunas viram `VARCHAR(30)` e os valores
   possiveis ficam anotados no comentario ao lado de cada coluna.

O mesmo SQL serve para **dbdiagram.io** (Import > From PostgreSQL), DrawSQL,
QuickDBD, pgModeler - e para criar o banco de verdade.

> As chaves estrangeiras ficam todas em `ALTER TABLE` no final do arquivo, entao
> a ordem de criacao das tabelas nao importa e nao ha erro de referencia futura.

| # | Diagrama | O que mostra |
|---|---|---|
| 01 | **Entidades** | Todas as entidades com atributos, tipos, PK/FK/UQ e obrigatoriedade. **Sem** linhas de relacionamento. |
| 02 | **Relacionamentos** | Todas as entidades com **apenas as chaves** (PK/FK) + todas as ligacoes com cardinalidade. Caixas pequenas, linhas legiveis. |
| 03 | **DER completo** | Atributos **e** relacionamentos juntos - a visao final do modelo. |

## Como gerar a imagem para o relatorio

### PlantUML (`puml/`)
1. Abra <https://www.plantuml.com/plantuml/uml/>.
2. Cole o conteudo do `.puml`.
3. Clique em **SVG**, nao PNG. Para baixar: botao direito na imagem ->
   "Salvar imagem como...".
4. No VS Code: extensao *PlantUML* -> `Alt+D` (preview) -> botao direito -> *Export*.

> **Use SVG, nao PNG.** O servidor publico do PlantUML corta o PNG em 4096px.
> O diagrama 03 tem 6055px de altura, entao o PNG sai truncado (falta o modulo
> "Usuarios" no rodape). Em SVG sai inteiro e o texto fica nitido em qualquer zoom.

### Layout: por que os diagramas 02 e 03 usam `left to right direction`

Sem essa linha o PlantUML monta uma **tira** larga e baixa, que nao cabe legivel
na pagina e estoura o limite do PNG:

| Diagrama | sem `left to right` | com `left to right` |
|---|---|---|
| 02 Relacionamentos | 4513 x 1354 (corta `denuncia`) | **1889 x 3553** |
| 03 DER completo | 7938 x 2018 (corta metade) | **3265 x 6055** |

O diagrama 01 nao precisa disso: ele nao tem linhas de relacionamento e usa uma
grade 3x3 de modulos (ligacoes invisiveis no fim do arquivo).

> Nota: nas legendas dos `.puml`, o caractere `|` da notacao pe-de-galinha e
> escrito como `&#124;`. Escrito cru, ele e interpretado como separador de
> celula da tabela e quebra a legenda.

### dbdiagram.io (`dbdiagram.io/`)
1. Abra <https://dbdiagram.io/d>.
2. Apague o exemplo e cole todo o conteudo do `.dbml`.
3. As tabelas ja vem coloridas por modulo e agrupadas em *TableGroup*.
4. Use **Export -> PDF/PNG** (ou *Print*) para o relatorio.

> Dica: no dbdiagram voce pode arrastar as caixas antes de exportar. Como cada
> modulo tem uma cor propria de cabecalho, basta juntar as caixas da mesma cor
> para o desenho ficar organizado em blocos.

## Cores por modulo (iguais nos dois formatos)

| # | Modulo | Cor | Entidades |
|---|---|---|---|
| 1 | Usuarios, Perfil e Acesso | azul `#3E5F8A` | usuario, perfil, endereco, token_recuperacao_senha, conquista, usuario_conquista, assinatura |
| 2 | Catalogo Global | verde `#2E7D5B` | categoria, raridade, idioma, estado_conservacao, album, carta, foto_carta, historico_preco |
| 3 | Colecao do Cliente | roxo `#7B4F9D` | colecao, album_usuario, colecao_carta |
| 4 | Comunidade (Grupos) | laranja `#C2703D` | grupo, membro_grupo, solicitacao_grupo, mensagem_grupo, enquete, opcao_enquete, voto_enquete |
| 5 | Chat Pessoal | ciano `#2A7B8C` | conversa, participante_conversa, mensagem, bloqueio_usuario |
| 6 | Marketplace | vinho `#A63D5F` | anuncio, foto_anuncio, proposta, pedido, pagamento, avaliacao |
| 7 | Notificacoes e Favoritos | dourado `#B08A2E` | favorito, alerta_preco, notificacao, notificacao_global |
| 8 | Moderacao e Administracao | cinza `#5A5A66` | denuncia, solicitacao_cadastro, log_auditoria, configuracao_global |

## Rastreabilidade (entidade -> casos de uso principais)

| Entidade | Casos de uso |
|---|---|
| `usuario`, `token_recuperacao_senha` | 03 Criar Conta, 04 Login, 06 Recuperar Senha, 52 Exclusao da Conta, 59 Gestao de Usuarios |
| `perfil`, `endereco`, `conquista`/`usuario_conquista` | 48 Editar Perfil, 49 Vitrine de Conquistas, 51 Privacidade e Senha |
| `assinatura` | Gerenciar Plano PRO (futuro) |
| `album`, `carta`, `categoria`, `raridade`, `idioma`, `estado_conservacao`, `foto_carta` | 08-10 Albuns, 13 Visualizar Cartas, 24-32 Buscas/Filtros, 30-31 Detalhes, 61 Gestao de Catalogo |
| `colecao`, `album_usuario`, `colecao_carta` | 07 Resumo, 12 Compartilhar Colecao, 14-18 Marcar/Quantidade/Remover, 19 Progresso, 22 Adicionar Carta, 35 Resetar Progresso, 36 Portfolio |
| `historico_preco` | 75 Historico de Precos |
| `grupo`, `membro_grupo`, `solicitacao_grupo` | 39 Explorar/Entrar em Grupos, 43 Criar e Administrar Grupo, 64 Aprovar Solicitacoes |
| `mensagem_grupo`, `enquete`, `opcao_enquete`, `voto_enquete` | 42 Historico do Grupo, 44 Chat do Grupo, 41 Silenciar, 62 Gestao de Comunidade |
| `conversa`, `participante_conversa`, `mensagem`, `bloqueio_usuario` | 45 Responder Mensagem, 46 Visualizar Mensagens, 47 Moderar Contatos, 73 Entrar em Contato |
| `anuncio`, `foto_anuncio` | 84 Criar / 85 Editar / 86 Excluir / 87 Pausar / 88 Reativar Anuncio, 76 Anuncios Ativos |
| `proposta` | 89 Visualizar Propostas |
| `pedido`, `pagamento` | 72 Comprar, 77 Visualizar Pedidos, 92 Total de Vendas, 93 Cartas Mais Vendidas |
| `avaliacao` | 70 Ordenar por Avaliacoes, 81 Visualizar Avaliacoes |
| `favorito` | 55 Favoritar Album, 56 Favoritar Carta, 57 Favoritar Grupo |
| `alerta_preco` | Configurar Alertas de Preco (futuro) |
| `notificacao`, `notificacao_global` | 53 Visualizar Notificacoes, 54 Limpar Central, 60 Disparar Notificacao Global |
| `denuncia` | 40 Denunciar Mensagem, 50 Denunciar Perfil, 82 Denunciar Anuncio, 83 Denunciar Vendedor, 90 Denunciar Usuario |
| `solicitacao_cadastro` | 21/23 Solicitar Cadastro de Carta, Solicitar Album, 64 Aprovar Solicitacoes |
| `log_auditoria` | 65 Log de Auditoria Admin |
| `configuracao_global` | 66 Configuracoes Globais |

## Convencoes

- Nomes de tabelas/colunas em `snake_case`, portugues, singular.
- `id` `bigint` auto-incremento como PK em todas as entidades fortes.
- Entidades associativas (N:N) com PK composta: `usuario_conquista`, `voto_enquete`, `participante_conversa`.
- Enums centralizados no topo dos arquivos `.dbml`.
- `favorito` e `denuncia` usam alvo polimorfico: FKs opcionais + coluna discriminadora (`tipo` / `tipo_alvo`).
- Notacao de cardinalidade: pe-de-galinha no PlantUML (`||--o{`) e `>` / `-` no DBML.
