| Nome do Caso de Uso | Buscar por Nome |
|---|---|
| Finalidade/Objetivo | Permitir que o cliente busque cartas pelo nome para localizar um item específico. |
| Atores | Cliente |
| Pré Condições | O cliente deve estar autenticado e estar na tela de pesquisa de cartas. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O cliente digita o nome da carta no campo de busca. |  |
|  | 2. O sistema pesquisa na base de dados as cartas cujo nome corresponda ao termo informado. |
|  | 3. O sistema exibe a lista de cartas encontradas. |
| 4. O cliente seleciona a carta desejada na lista de resultados. |  |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
|  | 1. Se o sistema não encontrar nenhuma carta correspondente ao nome informado, exibe a mensagem 'Nenhuma carta encontrada com os termos informados'. |
