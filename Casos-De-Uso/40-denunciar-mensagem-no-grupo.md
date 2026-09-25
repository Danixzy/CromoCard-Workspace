| Nome do Caso de Uso | Denunciar Mensagem no Grupo |
|---|---|
| Finalidade/Objetivo | Permitir que o usuário denuncie uma mensagem considerada inadequada ou que viole as regras da comunidade dentro de um grupo. |
| Atores | Cliente |
| Pré Condições | O usuário deve estar autenticado no sistema e ser membro do grupo onde a mensagem foi enviada. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O usuário acessa a tela do Grupo e localiza a mensagem que deseja denunciar. |  |
| 2. O usuário seleciona a opção 'Denunciar Mensagem' no menu de ações da mensagem. |  |
|  | 3. O sistema exibe um formulário com os motivos de denúncia (spam, conteúdo ofensivo, golpe, assédio, outro). |
| 4. O usuário seleciona o motivo da denúncia e, opcionalmente, adiciona uma descrição. |  |
| 5. O usuário confirma o envio da denúncia. |  |
|  | 6. O sistema registra a denúncia com status 'Pendente', notifica o administrador do grupo e a equipe de moderação da plataforma. |
|  | 7. O sistema exibe uma mensagem confirmando que a denúncia foi registrada com sucesso. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O usuário cancela a denúncia antes de confirmar. |  |
|  | 2. O sistema descarta o formulário e retorna à tela do grupo sem registrar a denúncia. |
