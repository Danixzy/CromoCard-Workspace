| Nome do Caso de Uso | Remover Álbum |
|---|---|
| Finalidade/Objetivo | Permitir a exclusão completa e a limpeza dos dados de progresso de um álbum específico da conta do usuário. |
| Atores | Cliente |
| Pré Condições | O usuário deve selecionar a opção de remoção nas configurações do respectivo álbum. |

### Fluxo Principal

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. O usuário clica no ícone de opções do álbum e seleciona 'Remover Álbum'. |  |
|  | 2. O sistema abre um modal de confirmação alertando que todo o progresso de marcação daquele checklist será perdido. |
| 3. O usuário clica no botão de confirmação definitiva |  |
|  | 4. O sistema exclui os vínculos lógicos do banco de dados e recarrega a listagem atualizada. |

### Fluxo Alternativo

| Ações do Ator | Ações do Sistema |
|---|---|
| 1. Caso o usuário clique em 'Cancelar' no modal de confirmação, o sistema fecha o pop-up sem realizar nenhuma alteração nos dados. |  |
