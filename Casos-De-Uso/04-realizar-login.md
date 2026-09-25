| Nome do Caso de Uso | Realizar Login |
|---|---|
| Finalidade/Objetivo | Permitir que o visitante faça login com e-mail/senha ou OAuth (Google/Facebook) para acessar sua conta. |
| Atores | Visitante |
| Pré Condições | O visitante deve possuir um cadastro ativo e estar na tela de Login. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O visitante acessa a tela de Login. |  |
|  | 2. Apresentar os campos de credenciais e opções de login social. |
| 3. O visitante informa e-mail e senha e clica em entrar. |  |
|  | 4. O sistema valida os campos preenchidos e a disponibilidade do e-mail. |
|  | 5. O sistema inicia a sessão do usuário e o redireciona para a Dashboard do Painel Cliente. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
|  | 1. Caso as credenciais não coincidam com a base de dados, emitir mensagem de erro 'E-mail ou senha incorretos'. |
