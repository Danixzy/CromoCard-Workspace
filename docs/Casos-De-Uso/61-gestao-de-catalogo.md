| Nome do Caso de Uso | Gestão de Catálogo |
|---|---|
| Finalidade/Objetivo | Permitir que o administrador envie uma notificação para todos os usuários da plataforma. |
| Atores | Administrador |
| Pré Condições | O administrador deve estar autenticado e possuir permissão para gerenciar o catálogo. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O administrador acessa a opção "Gestão de Catálogo". |  |
|  | 2. O sistema apresenta os itens cadastrados no catálogo. |
| 3. O administrador seleciona a opção de cadastrar, editar ou remover um item. |  |
|  | 4. O sistema apresenta o formulário ou as opções correspondentes. |
| 5. O administrador informa ou altera os dados do item. |  |
|  | 6. O sistema valida os dados informados. |
| 7. O administrador confirma a operação. |  |
|  | 8. O sistema registra a operação realizada. |
|  | 9. O sistema atualiza o catálogo e confirma a operação. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O administrador informa dados inválidos. |  |
|  | 2. O sistema informa os dados que precisam ser corrigidos. |
| 3. O administrador corrige os dados. |  |
|  | 4. O sistema realiza novamente a validação. |
| 5. O administrador tenta remover um item que possui vínculos que impedem sua exclusão. |  |
|  | 6. O sistema impede a exclusão e informa o motivo. |
