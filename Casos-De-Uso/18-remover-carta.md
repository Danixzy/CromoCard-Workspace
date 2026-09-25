| Nome do Caso de Uso | Remover Carta |
|---|---|
| Finalidade/Objetivo | Permitir que o cliente remova uma carta da sua coleção para manter os registros atualizados. |
| Atores | Cliente |
| Pré Condições | O cliente deve estar autenticado e possuir a carta em sua coleção. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O cliente seleciona uma carta e aciona o botão de diminuir quantidade (-) ou 'Remover'. |  |
|  | 2. O sistema subtrai a quantidade informada. |
|  | 3. O sistema avalia se a quantidade chegou a zero e, em caso afirmativo, altera o status para 'Faltante'. |
|  | 4. O sistema atualiza a interface e o progresso da coleção. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O cliente tenta remover uma carta cuja quantidade já é zero. |  |
|  | 2. O sistema mantém a ação desabilitada ou emite aviso de que a ação não é possível. |
