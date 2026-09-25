| Nome do Caso de Uso | Marcar Carta Repetida |
|---|---|
| Finalidade/Objetivo | Permitir que o cliente marque uma carta como repetida para identificar itens duplicados. |
| Atores | Cliente |
| Pré Condições | O cliente deve estar autenticado e possuir pelo menos uma unidade da carta. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O cliente localiza uma carta que já possui e marca a opção 'Repetida'. |  |
|  | 2. O sistema valida se o status atual permite a ação. |
|  | 3. O sistema incrementa o contador de repetidas e altera a indicação visual da carta. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O cliente tenta marcar como repetida uma carta que consta como faltante. |  |
|  | 2. O sistema converte automaticamente o status inicial para 'Possuo' antes de contabilizar a repetição. |
