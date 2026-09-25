| Nome do Caso de Uso | Criar e Administrar Grupo |
|---|---|
| Finalidade/Objetivo | Permitir que o usuário crie um novo grupo e gerencie seus membros, permissões e configurações. |
| Atores | Cliente (Administrador do Grupo) |
| Pré Condições | O usuário deve estar autenticado no sistema. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O usuário acessa a tela Listagem de Grupos e seleciona a opção 'Criar Grupo'. |  |
| 2. O usuário preenche as informações do grupo: nome, descrição, imagem de capa e tipo de acesso (aberto ou fechado). |  |
| 3. O usuário confirma a criação do grupo. |  |
|  | 4. O sistema cria o grupo, define o usuário como Administrador e exibe a tela do grupo recém-criado. |
|  | 5. O sistema disponibiliza as opções de administração: aprovar/recusar solicitações de entrada, remover membros, promover membros a administrador, editar informações do grupo e excluir o grupo. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
|  | 1. Caso os campos obrigatórios (nome e tipo de acesso) não estejam preenchidos, o sistema exibe mensagens de validação e impede a criação até que sejam corrigidos. |
|  | 2. Caso o administrador tente excluir o grupo, o sistema solicita confirmação antes de realizar a exclusão definitiva. |
