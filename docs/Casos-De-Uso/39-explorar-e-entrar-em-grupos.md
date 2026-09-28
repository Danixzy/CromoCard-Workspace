| Nome do Caso de Uso | Explorar e Entrar em Grupos |
|---|---|
| Finalidade/Objetivo | Permitir que o usuário busque, explore e entre em grupos (comunidades) de interesse relacionados a coleções de cartas. |
| Atores | Cliente |
| Pré Condições | O usuário deve estar autenticado no sistema. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O usuário acessa a tela Listagem de Grupos. |  |
| 2. O usuário utiliza o campo de busca para pesquisar grupos por nome ou tema. |  |
|  | 3. O sistema retorna a lista de grupos correspondentes à pesquisa, exibindo nome, descrição, quantidade de membros e tipo (aberto ou fechado). |
| 4. O usuário seleciona um grupo de interesse. |  |
|  | 5. Se o grupo for aberto, o sistema adiciona o usuário ao grupo imediatamente e exibe a tela do grupo. |
| 6. O usuário passa a participar do grupo. |  |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
|  | 1. Caso o grupo seja fechado, o sistema envia uma solicitação de entrada ao administrador e informa ao usuário que sua solicitação está pendente de aprovação. |
|  | 2. Caso a busca não retorne resultados, o sistema exibe uma mensagem informando que nenhum grupo foi encontrado e sugere a criação de um novo grupo. |
