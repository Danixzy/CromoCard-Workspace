| Nome do Caso de Uso | Reativar Anúncio |
|---|---|
| Finalidade/Objetivo | Como Vendedor preciso reativar um anúncio para disponibilizar novamente uma carta para venda. |
| Atores | Vendedor |
| Pré Condições | O vendedor deve ter um anúncio com o status 'Pausado'. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O vendedor acessa seus anúncios inativos e clica em 'Reativar' |  |
|  | 2. O sistema atualiza o status de 'Pausado' para 'Ativo' |
|  | 3. O sistema recoloca o anúncio nas listas de busca do marketplace |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
|  | 1. Se houver alguma restrição na conta do vendedor (ex: bloqueio temporário), o sistema impede a reativação e exibe uma notificação de erro |
