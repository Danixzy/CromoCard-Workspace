# ADRs — CromoCard

Architecture Decision Records extraídos por análise dos artefatos existentes
(Diagramas C4, DER, `CLAUDE.md` e documentos do `Azure-Devops/`). Nenhuma
decisão aqui é nova: cada ADR documenta formalmente uma escolha que já está
implícita nos diagramas e no modelo de dados, para que possa ser **validada
(ou revista) pelo PO** antes de virar referência oficial do projeto.

> Contexto: o Azure DevOps já teve um item de ADR (`#148 Estrutura de C4 e
> ADR` → `#150 Estrutura - ADR`, `Closed`), mas o conteúdo nunca chegou ao
> repositório — ver `Apresentacao-Banca/plano-apresentacao-banca.md` ("ADRs
> (#150) só no Azure DevOps ❌ Não está no repositório") e o item aberto
> `#270 Documentação das decisões de arquitetura (ADR)` no board. Estes
> arquivos fecham essa lacuna.

## Como usar

- **Status possíveis:** `Pendente` · `Aceita` · `Rejeitada` · `Substituída (por ADR-XXXX)`.
- **Todos os ADRs abaixo estão `Pendente`** — aguardando validação do PO/orientador.
- Depois de validado com o PO, atualize o campo `Status` do arquivo (e, se
  fizer sentido, replique o resultado no work item `#270` do Azure DevOps).
- Ao criar um novo ADR, use o próximo número sequencial e o mesmo template
  (contexto, decisão, alternativas consideradas, consequências, referências).

## Índice

| # | Título | Status |
|---|---|---|
| [0001](0001-separacao-de-clientes-por-plataforma.md) | Separação das aplicações cliente por plataforma (Web, Mobile, BackOffice) | Pendente |
| [0002](0002-stack-frontend-web-backoffice-react-vite.md) | Stack de frontend para Web e BackOffice: React + Vite | Pendente |
| [0003](0003-stack-mobile-react-native.md) | Stack do aplicativo mobile: React Native | Pendente |
| [0004](0004-stack-backend-node-express-prisma.md) | Stack de backend: Node.js + Express + Prisma | Pendente |
| [0005](0005-banco-de-dados-postgresql.md) | Banco de dados relacional: PostgreSQL via Prisma ORM | Pendente |
| [0006](0006-autenticacao-jwt-compartilhada.md) | Autenticação via JWT compartilhado entre API REST e serviço de tempo real | Pendente |
| [0007](0007-servico-tempo-real-dedicado.md) | Serviço de mensageria em tempo real como container dedicado | Pendente |
| [0008](0008-integracao-gateway-pagamento.md) | Integração com gateway de pagamento externo via HTTPS/Webhook | Pendente |
| [0009](0009-integracao-transportadora.md) | Integração com transportadora terceirizada para entrega física | Pendente |
| [0010](0010-modelagem-polimorfica-favorito-denuncia.md) | Modelagem polimórfica para alvos de `favorito` e `denuncia` | Pendente |
| [0011](0011-convencoes-modelagem-dados.md) | Convenções de modelagem de dados (nomenclatura, PK, associativas N:N) | Pendente |
| [0012](0012-trilha-auditoria-acoes-administrativas.md) | Trilha de auditoria obrigatória para ações administrativas | Pendente |
| [0013](0013-estrutura-multi-repositorio.md) | Estrutura multi-repositório (documentação separada das aplicações) | Pendente |
| [0014](0014-escopo-marketplace-no-mvp.md) | Escopo do Marketplace no MVP (decisão em aberto) | Pendente |
| [0015](0015-heranca-tipos-usuario-diagrama-classes.md) | Herança de tipos de usuário no diagrama de classes (Single Table Inheritance) | Pendente |
| [0016](0016-granularidade-diagrama-classes.md) | Granularidade do diagrama de classes (1:1 com as 43 entidades do DER) | Pendente |
| [0017](0017-notacao-relacionamento-diagrama-classes.md) | Notação de relacionamento no diagrama de classes (rótulo textual) | Pendente |
