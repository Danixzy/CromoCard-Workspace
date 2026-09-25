| Nome do Caso de Uso | Pesquisar no Histórico do Grupo |
|---|---|
| Finalidade/Objetivo | Permitir que o usuário pesquise mensagens, cartas, anúncios e mídias compartilhadas no histórico de conversas de um grupo. |
| Atores | Cliente |
| Pré Condições | O usuário deve estar autenticado no sistema e ser membro do grupo onde deseja realizar a pesquisa. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O usuário acessa a tela do Grupo e seleciona a opção 'Pesquisar'. |  |
| 2. O usuário digita o termo de busca no campo de pesquisa. |  |
|  | 3. O sistema busca no histórico de mensagens do grupo por correspondências no texto das mensagens, nomes de cartas compartilhadas e anúncios. |
|  | 4. O sistema exibe os resultados encontrados com destaque no termo pesquisado, data e autor da mensagem. |
| 5. O usuário seleciona um resultado para navegar até a mensagem no contexto da conversa. |  |
|  | 6. O sistema rola a conversa até a mensagem correspondente e a destaca visualmente. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
|  | 1. Caso a pesquisa não retorne resultados, o sistema exibe uma mensagem informando que nenhum conteúdo correspondente foi encontrado no histórico do grupo. |
