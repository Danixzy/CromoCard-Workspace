| Nome do Caso de Uso | Interagir no Chat do Grupo |
|---|---|
| Finalidade/Objetivo | Permitir que o usuário participe das conversas do grupo, enviando mensagens de texto, imagens, cartas, anúncios e enquetes. |
| Atores | Cliente |
| Pré Condições | O usuário deve estar autenticado no sistema e ser membro do grupo. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O usuário acessa a tela do Grupo. |  |
|  | 2. O sistema carrega e exibe o histórico de mensagens do grupo em ordem cronológica. |
| 3. O usuário digita uma mensagem no campo de texto e envia. |  |
|  | 4. O sistema publica a mensagem no chat do grupo e a exibe para todos os membros em tempo real. |
| 5. O usuário pode também compartilhar imagens, cartas da coleção, anúncios do marketplace ou criar enquetes utilizando os ícones de ação do chat. |  |
|  | 6. O sistema processa o tipo de conteúdo compartilhado e o exibe de forma formatada na conversa (preview de carta, card de anúncio, formulário de enquete). |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
|  | 1. Caso o grupo possua mensagens fixadas pelo administrador, o sistema exibe um indicador de mensagem fixada no topo do chat. |
|  | 2. Caso o usuário tente enviar conteúdo que viole as regras do grupo, o sistema bloqueia o envio e exibe uma mensagem informando a violação. |
