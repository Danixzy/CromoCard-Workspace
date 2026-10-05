# ADR-018 — Configuração e ambientes

- **Status:** Proposto
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard

## Contexto

O Git Flow (ADR-013) cria três destinos de código (`development`, `homolog`, `main`).
O backend depende de banco, segredos (JWT, SMTP, S3) e de serviços externos. É preciso
definir quais ambientes existem, de onde vêm as configurações e onde os segredos ficam.

## Decisão

### Ambientes
| Ambiente | Onde roda | Banco | Branch | `NODE_ENV` | `APP_ENV` |
|---|---|---|---|---|---|
| **local** | Máquina de cada dev | Postgres no docker-compose | qualquer | `development` | `local` |
| **test** | CI e `npm test` | Postgres de teste (descartável) | qualquer | `test` | `test` |
| **homolog** | Servidor (a definir, deploy em stand-by) | Banco próprio, com dados fictícios | `homolog` | `production` | `homolog` |
| **produção** | Servidor (a definir) | Banco próprio | `main` | `production` | `production` |

- `NODE_ENV` diz **como** o código roda (otimizações, Swagger desligado). `APP_ENV`
  diz **qual** ambiente é. A homologação roda como produção (`NODE_ENV=production`),
  mas continua sendo homologação (`APP_ENV=homolog`).
- A homologação **nunca** usa cópia de dados reais de produção.

### Configuração: só por variáveis de ambiente (12-factor)
- Toda configuração vem de variáveis de ambiente, lidas **num único lugar**:
  `src/config/env.ts`, que valida tudo com Zod e **impede a aplicação de subir** se
  faltar alguma variável ou se ela for inválida.
- O resto do código importa `env` desse arquivo e nunca lê `process.env` direto (regra do ESLint).
- Nomes em `UPPER_SNAKE_CASE`, agrupados por prefixo.

### Arquivos
| Arquivo | Versionado? | Conteúdo |
|---|---|---|
| `.env.example` | **Sim** | Todas as variáveis, com valores de exemplo e comentários |
| `.env` | **Não** (`.gitignore`) | Valores locais de cada dev |
| `.env.test` | Sim | Valores do ambiente de teste (sem segredos reais) |

### Segredos
- **Nunca** no repositório, nem em `.env.example`.
- **CI:** *Secrets* do GitHub Actions.
- **Homologação/produção:** variáveis de ambiente do serviço de hospedagem (a definir com o deploy).
- `JWT_SECRET` diferente em cada ambiente e com pelo menos 32 caracteres aleatórios.

### docker-compose (desenvolvimento local)
```yaml
services:
  postgres:      # postgres:18 — banco de dev, porta 5432
  postgres-test: # postgres:18 — banco de teste, porta 5433 (tmpfs: dados em memória, rápido e descartável)
  minio:         # opcional (profile "storage"), compatível com S3 — ADR-009
```
O Ethereal (e-mail) não precisa de container, porque é um serviço online de teste.

### Variáveis previstas (`.env.example`)
```bash
# App
NODE_ENV=development
APP_ENV=local
PORT=3333
CORS_ORIGINS=http://localhost:5173
# Banco
DATABASE_URL=postgresql://cromocard:cromocard@localhost:5432/cromocard
# Auth (ADR-005)
JWT_SECRET=troque-por-um-valor-aleatorio-de-32-caracteres
JWT_ACCESS_TTL=15m
REFRESH_TTL=1d
REFRESH_TTL_REMEMBER=30d
GOOGLE_CLIENT_ID=
# E-mail (ADR-009)
MAIL_DRIVER=ethereal        # ethereal | smtp
MAIL_FROM="CromoCard <no-reply@cromocard.dev>"
SMTP_HOST=
SMTP_PORT=
SMTP_USER=
SMTP_PASS=
# Storage (ADR-009)
STORAGE_DRIVER=local        # local | s3
S3_BUCKET=
S3_REGION=
S3_ENDPOINT=                # preenchido só com MinIO
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
# Jobs (ADR-010)
JOBS_ENABLED=true
# Logs (ADR-019)
LOG_LEVEL=debug
```

## Alternativas consideradas

- **Arquivos de config por ambiente no repositório** (`config/production.json`):
  misturam configuração com segredo e acabam indo para o Git.
- **Cofre de segredos** (Azure Key Vault, AWS Secrets Manager): é o ideal em produção
  real, mas é excessivo para o projeto agora.

## Consequências

- `git clone` + `cp .env.example .env` + `docker compose up` é tudo o que um dev novo precisa.
- Um erro de configuração aparece no boot, com mensagem clara, e não no meio de uma requisição.
- O detalhe de onde homologação e produção rodam fica para o ADR de deploy.
