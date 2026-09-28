| Nome do Caso de Uso | Marcar Carta como Faltante |
|---|---|
| Finalidade/Objetivo | Permitir que o cliente marque uma carta como faltante para identificar itens que precisa adquirir. |
| Atores | Cliente |
| Pré Condições | O cliente deve estar autenticado e na tela de visualização de cartas do álbum. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O cliente seleciona uma carta e marca a opção 'Faltante'. |  |
|  | 2. O sistema atualiza o status da carta na coleção do cliente para 'Faltante' e zera a quantidade, se houver. |
|  | 3. O sistema atualiza a exibição visual da carta e o progresso geral do álbum. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
|  | 1. O sistema mantém o botão desabilitado se a carta já possuir o status 'Faltante'. |
