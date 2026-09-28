| Nome do Caso de Uso | Editar Anúncio |
|---|---|
| Finalidade/Objetivo | Como Vendedor preciso editar meus anúncios para manter suas informações atualizadas. |
| Atores | Vendedor |
| Pré Condições | O vendedor deve possuir ao menos um anúncio ativo ou pausado na plataforma. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O vendedor acessa a lista dos seus anúncios e seleciona 'Editar' em um deles |  |
|  | 2. O sistema carrega o formulário com os dados atuais do anúncio |
| 3. O vendedor modifica as informações (ex: preço, descrição) e salva |  |
|  | 4. O sistema atualiza o registro no banco de dados e confirma a edição |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O vendedor tenta salvar deixando um campo obrigatório em branco |  |
|  | 2. O sistema impede a ação e solicita o preenchimento do campo |
