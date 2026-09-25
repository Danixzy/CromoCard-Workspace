| Nome do Caso de Uso | Denunciar Anúncio |
|---|---|
| Finalidade/Objetivo | Como Cliente preciso denunciar um anúncio para informar à plataforma possíveis irregularidades. |
| Atores | Cliente |
| Pré Condições | O cliente deve estar autenticado e na página de detalhes do anúncio que deseja denunciar. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O cliente seleciona a opção 'Denunciar Anúncio' |  |
|  | 2. O sistema apresenta um formulário/modal solicitando o motivo da denúncia |
| 3. O cliente seleciona o motivo (ex: fraude, item falso), adiciona uma observação e confirma |  |
|  | 4. O sistema registra a denúncia e emite uma mensagem de confirmação do envio |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O cliente tenta enviar a denúncia sem selecionar um motivo |  |
|  | 2. O sistema bloqueia o envio e destaca o campo obrigatório com uma mensagem de erro |
