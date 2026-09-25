| Nome do Caso de Uso | Visualizar Progresso |
|---|---|
| Finalidade/Objetivo | Permitir que o cliente visualize o progresso do álbum para acompanhar o percentual de cartas. |
| Atores | Cliente |
| Pré Condições | O cliente deve estar autenticado e possuir o álbum em sua coleção. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O cliente acessa a tela de resumo da sua coleção ou do álbum. |  |
|  | 2. O sistema calcula a proporção entre cartas possuídas e o total de cartas do álbum. |
|  | 3. O sistema renderiza a barra de progresso e o percentual de conclusão correspondente. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
|  | 1. Caso o álbum não tenha um número total de cartas cadastrado no sistema, exibir 'Progresso indisponível'. |
