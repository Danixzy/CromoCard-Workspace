| Nome do Caso de Uso | Configurações Globais |
|---|---|
| Finalidade/Objetivo | Permitir que o administrador configure parâmetros gerais que afetam o funcionamento da plataforma. |
| Atores | Administrador |
| Pré Condições | O administrador deve estar autenticado e possuir permissão para alterar as configurações globais. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O administrador acessa a opção "Configurações Globais". |  |
|  | 2. O sistema apresenta as configurações disponíveis. |
| 3. O administrador seleciona uma configuração. |  |
|  | 4. O sistema apresenta os valores atuais da configuração. |
| 5. O administrador altera os valores desejados. |  |
| 6. O sistema valida as informações inseridas. |  |
|  | 7. O administrador confirma as alterações. |
|  | 8. O sistema salva as novas configurações. |
|  | 9. O sistema confirma que as configurações foram atualizadas. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O administrador informa um valor inválido para uma configuração. |  |
|  | 2. O sistema identifica o valor inválido e informa o administrador. |
| 2. O sistema identifica o valor inválido e informa o administrador. |  |
|  | 4. O sistema realiza novamente a validação. |
| 5. O administrador cancela as alterações. |  |
|  | 6. O sistema descarta as alterações e mantém as configurações anteriores. |
