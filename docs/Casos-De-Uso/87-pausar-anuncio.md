| Nome do Caso de Uso | Pausar Anúncio |
|---|---|
| Finalidade/Objetivo | Como Vendedor preciso pausar um anúncio para interromper temporariamente sua disponibilidade para venda. |
| Atores | Vendedor |
| Pré Condições | O vendedor deve ter um anúncio com o status 'Ativo'. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O vendedor aciona o botão/switch de 'Pausar' no painel de gestão de anúncios |  |
|  | 2. O sistema atualiza o status do anúncio para 'Pausado' |
|  | 3. O sistema oculta imediatamente o anúncio das buscas e listagens públicas do marketplace |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
|  | 1. Caso o anúncio já possua uma negociação em andamento (carrinho/pagamento pendente), o sistema alerta que o anúncio não pode ser pausado no momento |
