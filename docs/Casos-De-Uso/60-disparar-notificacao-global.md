| Nome do Caso de Uso | Disparar Notificação Global |
|---|---|
| Finalidade/Objetivo | Permitir que o administrador envie uma notificação para todos os usuários da plataforma. |
| Atores | Administrador |
| Pré Condições | Pré-Condições: O administrador deve estar autenticado e possuir permissão para enviar notificações globais. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O administrador acessa a opção "Notificação Global". |  |
|  | 2. O sistema apresenta a tela para criação da notificação. |
| 3. O administrador informa o título e o conteúdo da notificação. |  |
|  | 4. O sistema valida as informações preenchidas. |
| 5. O administrador confirma o envio da notificação. |  |
|  | 6. O sistema envia a notificação para os usuários da plataforma. |
|  | 7. O sistema registra o disparo da notificação. |
|  | 8. O sistema informa ao administrador que a notificação foi enviada com sucesso. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O administrador tenta enviar uma notificação sem preencher os campos obrigatórios. |  |
|  | 2. O sistema informa quais campos precisam ser preenchidos. |
| 3. O administrador corrige as informações. |  |
|  | 4. O sistema permite o envio após a validação. |
| 5. O administrador cancela o envio. |  |
|  | 6. O sistema cancela a operação sem enviar a notificação. |
