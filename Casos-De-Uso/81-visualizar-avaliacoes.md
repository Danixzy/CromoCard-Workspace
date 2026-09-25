| Nome do Caso de Uso | Visualizar Avaliações |
|---|---|
| Finalidade/Objetivo | Como Cliente preciso visualizar as avaliações do vendedor para avaliar sua reputação na plataforma. |
| Atores | Cliente |
| Pré Condições | O cliente deve estar autenticado e visualizando a página de um anúncio ou o perfil do vendedor. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O cliente clica na seção de 'Avaliações' do vendedor |  |
|  | 2. O sistema busca no banco de dados o histórico de avaliações e a nota média |
|  | 3. O sistema exibe a nota consolidada e a lista de comentários dos compradores |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
|  | 1. Caso o vendedor ainda não tenha concluído nenhuma venda avaliada, o sistema exibe a mensagem 'Este vendedor ainda não possui avaliações' |
