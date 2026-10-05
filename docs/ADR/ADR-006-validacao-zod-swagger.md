# ADR-006 — Validação com Zod e Swagger gerado a partir dos validators

- **Status:** Aceito
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard

## Contexto

Toda entrada (body, params, query) precisa ser validada, tipada no TypeScript e
documentada no Swagger. Se cada uma dessas coisas for escrita à mão, as três saem de
sincronia.

## Decisão

- Cada domínio tem um **`<dominio>.validator.ts`** com schemas **Zod**. Um mesmo schema:
  1. **valida** a requisição, pelo middleware `validate({ body, params, query })`;
  2. **gera o tipo** TypeScript de entrada (`z.infer<typeof createUserSchema>`), usado
     pela service como DTO;
  3. **gera a documentação**, pelo `@asteasolutions/zod-to-openapi`, no `<dominio>.swagger.ts`.
- O Swagger UI (`swagger-ui-express`) fica em `/docs` e só é habilitado fora de produção.
- Erros de validação respondem **400** num formato único:
  ```json
  { "error": "VALIDATION_ERROR", "message": "Dados inválidos", "details": [{ "field": "email", "message": "E-mail inválido" }] }
  ```
- Todos os erros da API seguem o formato `{ error, message, details? }`, produzido
  pelo `errorHandler` global a partir de `AppError`.
- As variáveis de ambiente também são validadas com Zod (`src/config/env.ts`), e a
  aplicação não sobe se faltar alguma.

## Alternativas consideradas

- **class-validator + DTOs em classe:** depende de decorators e duplica os tipos.
- **Joi / Yup:** não geram tipos TypeScript tão bem quanto o Zod.
- **Swagger escrito à mão (YAML/JSDoc):** a documentação acaba mentindo sobre o que a API aceita.

## Consequências

- O validator é a fonte única de verdade para os contratos de entrada.
- Os schemas de **resposta** também são descritos em Zod no `.swagger.ts`, para a
  documentação ficar completa.
