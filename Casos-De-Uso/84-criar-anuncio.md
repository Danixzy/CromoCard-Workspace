| Nome do Caso de Uso | Criar Anúncio |
|---|---|
| Finalidade/Objetivo | Como Vendedor preciso criar um anúncio para disponibilizar minhas cartas para venda no marketplace. |
| Atores | Vendedor |
| Pré Condições | O usuário deve estar autenticado com perfil de Vendedor e possuir a carta em seu inventário virtual. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O vendedor seleciona a carta que deseja vender e clica em 'Criar Anúncio' |  |
|  | 2. O sistema exibe o formulário de anúncio solicitando preço, estado de conservação e fotos |
| 3. O vendedor preenche os dados e clica em 'Publicar' |  |
|  | 4. O sistema valida as informações inseridas |
|  | 5. O sistema cria o anúncio e o torna visível no marketplace |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O vendedor informa um valor de venda zerado ou negativo |  |
|  | 2. O sistema exibe um alerta de validação 'Por favor, insira um valor válido maior que zero' |
