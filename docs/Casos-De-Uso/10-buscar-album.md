| Nome do Caso de Uso | Buscar Álbum |
|---|---|
| Finalidade/Objetivo | Permitir que o usuário envie uma sugestão de cadastro para um novo álbum que não foi localizado no catálogo global. |
| Atores | Cliente |
| Pré Condições | O usuário deve preencher o formulário de solicitações dentro da área de biblioteca. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O usuário clica na opção 'Solicitar cadastro de álbum'. |  |
|  | 2. O sistema exibe um formulário solicitando Título, Editora/Ano e uma descrição opcional. |
| 3. O usuário preenche os campos obrigatórios e confirma o envio. |  |
|  | 4. O sistema grava a requisição na tabela de pendências para auditoria do BackOffice e emite um alerta de sucesso. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
|  | 1. Se o usuário não tiver álbuns adicionados, o sistema apresenta uma tela com uma mensagem informativa e um botão direcionando para o Catálogo Global. |
