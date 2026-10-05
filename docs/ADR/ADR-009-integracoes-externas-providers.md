# ADR-009 — Integrações externas via providers: CEP, e-mail, storage, pagamento

- **Status:** Aceito
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard

## Contexto

O backend depende de serviços externos: busca de CEP (cadastro de endereço), envio
de e-mail (confirmação de conta, recuperação de senha), armazenamento de imagens
(avatar, fotos de cartas e anúncios), gateway de pagamento e transportadora. Cada um
tem uma opção para desenvolvimento e outra para produção.

## Decisão

Toda integração externa é acessada por uma **interface (provider)** em
`src/infra/providers/<tipo>/`. As services dependem da interface, nunca do SDK
concreto. A implementação é escolhida por variável de ambiente no `.module.ts`.

| Provider | Interface | Desenvolvimento | Produção |
|---|---|---|---|
| CEP | `ZipCodeProvider.lookup(cep)` | **ViaCEP** | ViaCEP, com fallback para **BrasilAPI** |
| E-mail | `MailProvider.send({ to, subject, html })` | **Nodemailer + Ethereal** (e-mails não são entregues; o link de visualização aparece no log) | SMTP real (ex.: Amazon SES, Resend) |
| Storage | `StorageProvider.upload / delete / getUrl` | Disco local (`uploads/`) ou **MinIO** no docker-compose (compatível com S3) | **Amazon S3** (`@aws-sdk/client-s3`, URLs pré-assinadas) |
| Pagamento | `PaymentProvider` | Fake / sandbox | Mercado Pago ou Stripe (futuro marketplace) |
| Transportadora | `ShippingProvider` | Fake com frete fixo | A definir (futuro marketplace) |

**Sobre o CEP:** ViaCEP e BrasilAPI são gratuitos e não exigem cadastro. O
**CEP Aberto** exige cadastro e token, e tem limite de requisições, por isso ficou
como alternativa. Resultados de CEP podem ser guardados em cache, porque CEP quase
nunca muda.

**Sobre o S3:** a configuração fica para depois, mas a interface `StorageProvider`
entra desde o início. Assim a troca de "disco local" para "S3" é só uma variável de
ambiente (`STORAGE_DRIVER=local|s3`). As imagens nunca são gravadas no banco: o banco
guarda só a URL/chave (`avatar_url`, `card_photos.url` etc.).

## Alternativas consideradas

- **Chamar os SDKs direto nas services:** acopla a regra de negócio ao fornecedor e
  impede testar sem internet.

## Consequências

- Nos testes, as services recebem providers falsos (ex.: `FakeMailProvider` guarda os e-mails em memória).
- Chamadas externas têm timeout e erro tratado (ex.: CEP fora do ar → `503` com mensagem clara, sem derrubar o cadastro).
- Variáveis: `MAIL_DRIVER`, `SMTP_*`, `STORAGE_DRIVER`, `S3_BUCKET`, `S3_REGION`, `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`…
