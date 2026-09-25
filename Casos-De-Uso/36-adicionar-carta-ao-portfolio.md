| Nome do Caso de Uso | Adicionar Carta ao Portfólio |
|---|---|
| Finalidade/Objetivo | Permitir que o usuário adicione uma carta à sua coleção pessoal, registrando-a como item que possui. |
| Atores | Cliente |
| Pré Condições | O usuário deve estar autenticado no sistema e possuir pelo menos um álbum cadastrado. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O usuário acessa a tela Álbum ou a tela Cadastro de Carta. |  |
| 2. O usuário localiza a carta desejada (por pesquisa, escaneamento de imagem ou código). |  |
|  | 3. O sistema exibe as informações da carta encontrada (nome, número, coleção, imagem). |
| 4. O usuário seleciona a opção 'Adicionar ao Portfólio' e informa a quantidade. |  |
|  | 5. O sistema registra a carta na coleção do usuário com o status 'possuo' e a quantidade informada. |
|  | 6. O sistema atualiza o progresso do álbum correspondente e exibe uma mensagem de sucesso. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
|  | 1. Caso a carta já esteja registrada no portfólio do usuário, o sistema informa que o item já existe e oferece a opção de atualizar a quantidade. |
|  | 2. Caso a carta não seja encontrada na base de dados, o sistema oferece a opção de 'Solicitar Cadastro da Carta'. |
