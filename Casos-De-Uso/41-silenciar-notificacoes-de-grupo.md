| Nome do Caso de Uso | Silenciar Notificações de Grupo |
|---|---|
| Finalidade/Objetivo | Permitir que o usuário silencie as notificações de um grupo específico para não receber alertas de novas mensagens e atividades. |
| Atores | Cliente |
| Pré Condições | O usuário deve estar autenticado no sistema e ser membro do grupo que deseja silenciar. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O usuário acessa a tela do Grupo e seleciona as configurações ou menu de opções do grupo. |  |
| 2. O usuário seleciona a opção 'Silenciar Notificações'. |  |
|  | 3. O sistema exibe as opções de período de silenciamento (8 horas, 1 semana, até eu reativar). |
| 4. O usuário escolhe o período desejado. |  |
|  | 5. O sistema desativa as notificações do grupo pelo período selecionado e exibe um indicador visual de que o grupo está silenciado. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. Caso o usuário deseje reativar as notificações antes do período escolhido, ele acessa as opções do grupo e seleciona 'Reativar Notificações'. |  |
|  | 2. O sistema reativa as notificações imediatamente e remove o indicador de silenciamento. |
