| Nome do Caso de Uso | Buscar por Número |
|---|---|
| Finalidade/Objetivo | Permitir que o cliente busque cartas pelo número para encontrar uma carta específica dentro de uma coleção. |
| Atores | Cliente |
| Pré Condições | O cliente deve estar autenticado e estar na tela de pesquisa de cartas. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O cliente informa o número da carta no campo de busca. |  |
|  | 2. O sistema pesquisa na base de dados as cartas cujo número corresponda ao valor informado. |
|  | 3. O sistema exibe a lista de cartas encontradas. |
| 4. O cliente seleciona a carta desejada na lista de resultados. |  |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
|  | 1. Se o sistema não encontrar nenhuma carta com o número informado, exibe a mensagem 'Nenhuma carta encontrada com os termos informados'. |
