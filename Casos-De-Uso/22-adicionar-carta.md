| Nome do Caso de Uso | Adicionar Carta |
|---|---|
| Finalidade/Objetivo | Permitir que o cliente adicione uma carta à sua coleção para registrar o item entre os seus itens. |
| Atores | Cliente |
| Pré Condições | O cliente deve estar autenticado e ter localizado a carta na plataforma. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O cliente seleciona a opção de 'Adicionar' na carta desejada. |  |
|  | 2. O sistema inclui a carta na coleção do cliente com quantidade inicial de 1. |
|  | 3. O sistema atualiza o status visual da carta na interface e recalcula o progresso do álbum. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O cliente tenta adicionar uma carta que já consta em sua coleção. |  |
|  | 2. O sistema incrementa a quantidade da carta automaticamente em vez de criar um registro duplicado, notificando o cliente da atualização. |
