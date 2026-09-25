| Nome do Caso de Uso | Aprovar Solicitações |
|---|---|
| Finalidade/Objetivo | Permitir que o administrador analise e aprove solicitações realizadas pelos usuários da plataforma. |
| Atores | Administrador |
| Pré Condições | Permitir que o administrador gere e exporte relatórios com informações gerenciais da plataforma.O administrador deve estar autenticado e existir pelo menos uma solicitação pendente. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O administrador acessa a opção "Solicitações". |  |
|  | 2. O sistema apresenta as solicitações pendentes. |
| 3. O administrador seleciona o tipo de relatório e os filtros desejados. |  |
|  | 4. O sistema apresenta os detalhes da solicitação. |
| 5. O administrador analisa as informações. |  |
| 6. O administrador seleciona a opção "Aprovar". |  |
| 7. O administrador confirma a operação. |  |
|  | 7. O sistema gera o arquivo do relatório.7. O sistema registra a aprovação. |
|  | 8. O sistema disponibiliza o arquivo para o administrador.8. O sistema atualiza o status da solicitação. |
|  | 9. O sistema informa ao administrador que a solicitação foi aprovada. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O administrador seleciona uma solicitação que já foi processada. |  |
|  | 2. O sistema informa que a solicitação não está mais disponível para aprovação. |
| 3. O administrador altera os filtros.3. O administrador cancela a operação. |  |
|  | 4. O sistema retorna para a lista de solicitações. |
