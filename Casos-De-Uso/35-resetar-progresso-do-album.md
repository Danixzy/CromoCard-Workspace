| Nome do Caso de Uso | Resetar Progresso do Álbum |
|---|---|
| Finalidade/Objetivo | Permitir que o usuário reinicie o progresso de um álbum, desmarcando todas as cartas registradas como possuídas, faltantes ou repetidas. |
| Atores | Cliente |
| Pré Condições | O usuário deve estar autenticado no sistema e possuir um álbum com pelo menos uma carta marcada. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O usuário acessa a tela Álbum e seleciona o álbum desejado. |  |
| 2. O usuário seleciona a opção 'Resetar Progresso'. |  |
|  | 3. O sistema exibe uma mensagem de confirmação informando que todas as marcações de cartas (possuo, faltante, repetida e quantidades) serão removidas. |
| 4. O usuário confirma a operação. |  |
|  | 5. O sistema remove todas as marcações e quantidades das cartas do álbum e atualiza o progresso para 0%. |
|  | 6. O sistema exibe uma mensagem de sucesso confirmando o reset. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O usuário cancela a confirmação de reset. |  |
|  | 2. O sistema cancela a operação e mantém o progresso atual inalterado. |
