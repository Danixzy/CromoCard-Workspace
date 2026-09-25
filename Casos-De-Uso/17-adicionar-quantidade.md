| Nome do Caso de Uso | Adicionar Quantidade |
|---|---|
| Finalidade/Objetivo | Permitir que o cliente adicione a quantidade de uma carta para registrar quantas unidades possui. |
| Atores | Cliente |
| Pré Condições | O cliente deve estar autenticado e acessando o gerenciamento da sua coleção. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O cliente seleciona uma carta e clica no botão para aumentar a quantidade (+). |  |
|  | 2. O sistema atualiza a quantidade registrada no banco de dados para a carta específica. |
|  | 3. O sistema exibe o novo valor numérico na interface da carta. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O cliente tenta inserir um valor manual inválido. |  |
|  | 2. O sistema bloqueia a entrada, não salva a alteração e exibe alerta de valor incorreto. |
