| Nome do Caso de Uso | Recuperar Senha |
|---|---|
| Finalidade/Objetivo | Permitir que o visitante solicite a recuperação da senha esquecida através do e-mail. |
| Atores | Visitante |
| Pré Condições | O visitante deve estar na tela de Login e selecionar a opção de recuperação. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O visitante seleciona a opção 'Esqueci minha senha'. |  |
|  | 2. Solicitar o preenchimento do e-mail cadastrado. |
| 3. Informar o e-mail solicitado. |  |
|  | 4. O sistema verifica se o e-mail existe na base de dados. |
|  | 5. O sistema envia um link de redefinição para o e-mail e exibe confirmação na tela. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
|  | 1. Caso o e-mail não possua formato válido, emitir mensagem de erro. (Por segurança, não informar se o e-mail não existe na base, apenas exibir mensagem genérica de envio). |
