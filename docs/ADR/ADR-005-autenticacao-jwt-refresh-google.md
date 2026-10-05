# ADR-005 — Autenticação: JWT + refresh token + login Google (OIDC)

- **Status:** Aceito
- **Data:** 2026-09-28
- **Decisores:** Equipe CromoCard

## Contexto

O caso de uso CCD004 pede login com e-mail/senha **ou Google**, com a opção
"lembrar usuário". O C4 define autenticação via JWT na API e no WebSocket. Havia uma
dúvida entre "usar JWT ou OAuth2".

**JWT e OAuth2 não são alternativas.** O **JWT** é um *formato de token*, o crachá
que o cliente envia a cada requisição. O **OAuth2 / OpenID Connect** é um
*protocolo* para delegar o login a um provedor externo (Google). Os dois são usados juntos.

## Decisão

1. **E-mail e senha:** senha armazenada com hash **argon2** (ou bcrypt, custo ≥ 12).
2. **Google:** o frontend obtém o `id_token` pelo Google Identity Services e envia
   para `POST /auth/google`. A API valida o token com `google-auth-library`
   (assinatura, `aud` e `exp`), procura ou cria o usuário por
   `oauth_provider = 'google'` + `oauth_id = sub` e segue o mesmo fluxo do login com
   senha. **A API não implementa um servidor OAuth2**, apenas consome o do Google.
3. **Tokens emitidos pela API (nos dois casos):**
   - **Access token:** JWT assinado (HS256, segredo em `JWT_SECRET`), válido por
     **15 min**. Payload mínimo: `sub` (id do usuário) e `role`. Enviado em
     `Authorization: Bearer <token>`.
   - **Refresh token:** valor aleatório opaco (não é JWT), guardado **apenas como
     hash** na tabela `refresh_tokens`. Validade de 1 dia, ou 30 dias com "lembrar
     usuário". Na web, vai em cookie `httpOnly` + `Secure` + `SameSite`. No mobile,
     fica no armazenamento seguro do app.
   - **Rotação:** cada `POST /auth/refresh` revoga o refresh usado e emite um novo.
     Se um refresh já revogado for reutilizado, todas as sessões do usuário são
     revogadas (indício de roubo).
   - **Logout:** revoga o refresh token (`revoked_at`).
4. **Autorização por papel:** middleware `authorize('ADMIN')`, `authorize('SELLER')` etc.,
   baseado em `users.role`. Regras de posse (ex.: "só o dono edita o anúncio") ficam na service.
5. **WebSocket:** o access token é enviado no handshake e validado pelo mesmo módulo de auth.
6. Usuários com `status = SUSPENDED` ou com `deleted_at` preenchido não conseguem logar nem renovar token (conta excluída: ver ADR-015).

## Alternativas consideradas

- **Somente JWT de longa duração:** não dá para revogar (logout, conta suspensa), e
  um token vazado vale por dias.
- **Sessão em memória/Redis com cookie:** funciona bem na web, mas é pior para o app
  mobile e para o WebSocket.
- **Provedor gerenciado (Auth0, Firebase Auth, Cognito):** resolve tudo, mas tira da
  equipe o aprendizado e cria dependência de serviço pago.

## Consequências

- Nova tabela `refresh_tokens` no DER (`id`, `user_id`, `token_hash`, `expires_at`,
  `revoked_at`, `user_agent`, `ip_address`, `created_at`).
- O frontend precisa de um interceptor que, ao receber `401`, chame `/auth/refresh`
  e repita a requisição.
- Variáveis: `JWT_SECRET`, `JWT_ACCESS_TTL`, `REFRESH_TTL`, `REFRESH_TTL_REMEMBER`, `GOOGLE_CLIENT_ID`.
- Um job de limpeza remove refresh tokens expirados (ADR-010).
