| Nome do Caso de Uso | Marcar Carta como Possuo |
|---|---|
| Finalidade/Objetivo | Permitir que o cliente marque uma carta como possuída para registrar que o item faz parte da coleção. |
| Atores | Cliente |
| Pré Condições | O cliente deve estar autenticado e na tela de visualização de cartas do álbum. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O cliente seleciona uma carta e marca a opção 'Possuo'. |  |
|  | 2. O sistema valida a solicitação de alteração de status. |
|  | 3. O sistema atualiza o status da carta para 'Possuo' na coleção do cliente. |
|  | 4. O sistema recalcula o progresso do álbum. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
|  | 1. Caso haja instabilidade na conexão, o sistema informa erro ao salvar e orienta tentar novamente. |
