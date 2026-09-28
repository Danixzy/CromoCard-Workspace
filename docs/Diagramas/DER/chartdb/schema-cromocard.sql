-- =====================================================================
--  CromoCard - Sistema de Gestao de Cartas Colecionaveis
--  DER COMPLETO - DDL PostgreSQL
--
--  COMO USAR NO ChartDB (https://app.chartdb.io):
--    1. Abra o ChartDB e escolha 'Import' / 'Start from SQL script'
--    2. Selecione o dialeto PostgreSQL
--    3. Cole este arquivo inteiro e confirme
--
--  Serve tambem para dbdiagram.io (Import > From PostgreSQL),
--  DrawSQL, QuickDBD, pgModeler e para criar o banco de verdade.
--
--  43 tabelas | 76 chaves estrangeiras | 22 enums
--  Gerado a partir de DER/dbdiagram.io/03-der-completo.dbml
-- =====================================================================

-- ---------------------------------------------------------------------
-- TIPOS ENUMERADOS
-- ---------------------------------------------------------------------
CREATE TYPE tipo_usuario AS ENUM ('CLIENTE', 'VENDEDOR', 'ADMINISTRADOR');
CREATE TYPE status_usuario AS ENUM ('ATIVO', 'SUSPENSO', 'EXCLUIDO');
CREATE TYPE privacidade AS ENUM ('PUBLICO', 'PRIVADO');
CREATE TYPE tipo_categoria AS ENUM ('ALBUM', 'CARTA');
CREATE TYPE status_album AS ENUM ('ATIVO', 'INATIVO');
CREATE TYPE origem_preco AS ENUM ('VENDA', 'ANUNCIO');
CREATE TYPE status_plano AS ENUM ('ATIVA', 'CANCELADA', 'EXPIRADA');
CREATE TYPE status_carta_colecao AS ENUM ('POSSUO', 'FALTANTE', 'REPETIDA');
CREATE TYPE tipo_acesso_grupo AS ENUM ('ABERTO', 'FECHADO');
CREATE TYPE status_grupo AS ENUM ('ATIVO', 'SUSPENSO', 'EXCLUIDO');
CREATE TYPE papel_membro AS ENUM ('MEMBRO', 'ADMIN');
CREATE TYPE status_solicitacao AS ENUM ('PENDENTE', 'APROVADA', 'RECUSADA');
CREATE TYPE tipo_conteudo_msg AS ENUM ('TEXTO', 'IMAGEM', 'CARTA', 'ANUNCIO', 'ENQUETE');
CREATE TYPE status_anuncio AS ENUM ('ATIVO', 'PAUSADO', 'ENCERRADO', 'EXCLUIDO');
CREATE TYPE status_proposta AS ENUM ('PENDENTE', 'ACEITA', 'RECUSADA', 'EXPIRADA');
CREATE TYPE status_pedido AS ENUM ('AGUARDANDO_PAGAMENTO', 'PAGO', 'ENVIADO', 'ENTREGUE', 'CANCELADO');
CREATE TYPE metodo_pagamento AS ENUM ('CARTAO_CREDITO', 'PIX', 'BOLETO');
CREATE TYPE status_pagamento AS ENUM ('PENDENTE', 'APROVADO', 'RECUSADO', 'ESTORNADO');
CREATE TYPE tipo_favorito AS ENUM ('ALBUM', 'CARTA', 'GRUPO');
CREATE TYPE tipo_alvo_denuncia AS ENUM ('ANUNCIO', 'VENDEDOR', 'USUARIO', 'PERFIL', 'MENSAGEM_GRUPO');
CREATE TYPE status_denuncia AS ENUM ('PENDENTE', 'EM_ANALISE', 'RESOLVIDA', 'DESCARTADA');
CREATE TYPE tipo_solic_cadastro AS ENUM ('CARTA', 'ALBUM', 'CATEGORIA');

-- ---------------------------------------------------------------------
-- TABELAS
-- ---------------------------------------------------------------------

-- ===== 1 - USUARIOS, PERFIL E ACESSO =====

CREATE TABLE usuario (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(160) NOT NULL UNIQUE,
    senha_hash VARCHAR(255),
    tipo_usuario tipo_usuario NOT NULL,
    status status_usuario NOT NULL DEFAULT 'ATIVO',
    email_confirmado BOOLEAN NOT NULL DEFAULT false,
    aceite_termos BOOLEAN NOT NULL DEFAULT false,
    oauth_provider VARCHAR(30),
    oauth_id VARCHAR(120),
    data_cadastro TIMESTAMP NOT NULL DEFAULT now(),
    data_exclusao TIMESTAMP
);

CREATE TABLE perfil (
    id BIGSERIAL PRIMARY KEY,
    usuario_id BIGINT NOT NULL UNIQUE,
    bio TEXT,
    avatar_url VARCHAR(255),
    cidade VARCHAR(120),
    privacidade_portfolio privacidade NOT NULL DEFAULT 'PUBLICO'
);

CREATE TABLE endereco (
    id BIGSERIAL PRIMARY KEY,
    usuario_id BIGINT NOT NULL,
    rotulo VARCHAR(60) NOT NULL,
    cep VARCHAR(9) NOT NULL,
    logradouro VARCHAR(160) NOT NULL,
    numero VARCHAR(15) NOT NULL,
    complemento VARCHAR(60),
    bairro VARCHAR(90) NOT NULL,
    cidade VARCHAR(90) NOT NULL,
    estado CHAR(2) NOT NULL,
    principal BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE token_recuperacao_senha (
    id BIGSERIAL PRIMARY KEY,
    usuario_id BIGINT NOT NULL,
    token VARCHAR(255) NOT NULL UNIQUE,
    expira_em TIMESTAMP NOT NULL,
    usado BOOLEAN NOT NULL DEFAULT false,
    data_criacao TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE conquista (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(90) NOT NULL UNIQUE,
    descricao VARCHAR(255) NOT NULL,
    icone_url VARCHAR(255),
    criterio VARCHAR(255) NOT NULL
);

CREATE TABLE usuario_conquista (
    usuario_id BIGINT NOT NULL,
    conquista_id BIGINT NOT NULL,
    data_obtencao TIMESTAMP NOT NULL DEFAULT now(),
    PRIMARY KEY (usuario_id, conquista_id)
);

CREATE TABLE assinatura (
    id BIGSERIAL PRIMARY KEY,
    usuario_id BIGINT NOT NULL,
    plano VARCHAR(20) NOT NULL DEFAULT 'PRO',
    status status_plano NOT NULL DEFAULT 'ATIVA',
    metodo_pagamento metodo_pagamento NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    gateway_referencia VARCHAR(120)
);

-- ===== 2 - CATALOGO GLOBAL (ALBUNS E CARTAS) =====

CREATE TABLE categoria (
    id BIGSERIAL PRIMARY KEY,
    categoria_pai_id BIGINT,
    nome VARCHAR(90) NOT NULL,
    tipo tipo_categoria NOT NULL,
    descricao VARCHAR(255),
    padrao BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE raridade (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(60) NOT NULL UNIQUE,
    ordem SMALLINT NOT NULL
);

CREATE TABLE idioma (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    codigo VARCHAR(5) NOT NULL UNIQUE
);

CREATE TABLE estado_conservacao (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(60) NOT NULL UNIQUE,
    ordem SMALLINT NOT NULL
);

CREATE TABLE album (
    id BIGSERIAL PRIMARY KEY,
    categoria_id BIGINT,
    titulo VARCHAR(160) NOT NULL,
    editora VARCHAR(120),
    ano SMALLINT,
    descricao TEXT,
    capa_url VARCHAR(255),
    total_cartas INTEGER NOT NULL DEFAULT 0,
    status status_album NOT NULL DEFAULT 'ATIVO',
    data_cadastro TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE carta (
    id BIGSERIAL PRIMARY KEY,
    album_id BIGINT,
    categoria_id BIGINT,
    raridade_id BIGINT,
    idioma_id BIGINT,
    nome VARCHAR(160) NOT NULL,
    numero VARCHAR(20),
    descricao TEXT,
    imagem_frente_url VARCHAR(255),
    imagem_verso_url VARCHAR(255),
    data_cadastro TIMESTAMP NOT NULL DEFAULT now(),
    UNIQUE (album_id, numero)
);

CREATE TABLE foto_carta (
    id BIGSERIAL PRIMARY KEY,
    carta_id BIGINT NOT NULL,
    url VARCHAR(255) NOT NULL,
    ordem SMALLINT NOT NULL DEFAULT 0
);

CREATE TABLE historico_preco (
    id BIGSERIAL PRIMARY KEY,
    carta_id BIGINT NOT NULL,
    preco NUMERIC(10,2) NOT NULL,
    data_referencia DATE NOT NULL,
    origem origem_preco NOT NULL
);

-- ===== 3 - COLECAO DO CLIENTE =====

CREATE TABLE colecao (
    id BIGSERIAL PRIMARY KEY,
    usuario_id BIGINT NOT NULL UNIQUE,
    publica BOOLEAN NOT NULL DEFAULT false,
    link_compartilhamento VARCHAR(120) UNIQUE,
    data_criacao TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE album_usuario (
    id BIGSERIAL PRIMARY KEY,
    colecao_id BIGINT NOT NULL,
    album_id BIGINT NOT NULL,
    favorito BOOLEAN NOT NULL DEFAULT false,
    progresso_percentual NUMERIC(5,2) NOT NULL DEFAULT 0,
    data_inicio TIMESTAMP NOT NULL DEFAULT now(),
    UNIQUE (colecao_id, album_id)
);

CREATE TABLE colecao_carta (
    id BIGSERIAL PRIMARY KEY,
    colecao_id BIGINT NOT NULL,
    carta_id BIGINT NOT NULL,
    status status_carta_colecao NOT NULL,
    quantidade INTEGER NOT NULL DEFAULT 1,
    valor_mercado NUMERIC(10,2),
    data_adicao TIMESTAMP NOT NULL DEFAULT now(),
    UNIQUE (colecao_id, carta_id)
);

-- ===== 4 - COMUNIDADE (GRUPOS) =====

CREATE TABLE grupo (
    id BIGSERIAL PRIMARY KEY,
    criador_id BIGINT NOT NULL,
    nome VARCHAR(120) NOT NULL,
    descricao TEXT,
    imagem_capa_url VARCHAR(255),
    tipo_acesso tipo_acesso_grupo NOT NULL,
    status status_grupo NOT NULL DEFAULT 'ATIVO',
    data_criacao TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE membro_grupo (
    id BIGSERIAL PRIMARY KEY,
    grupo_id BIGINT NOT NULL,
    usuario_id BIGINT NOT NULL,
    papel papel_membro NOT NULL DEFAULT 'MEMBRO',
    data_entrada TIMESTAMP NOT NULL DEFAULT now(),
    silenciado_ate TIMESTAMP,
    UNIQUE (grupo_id, usuario_id)
);

CREATE TABLE solicitacao_grupo (
    id BIGSERIAL PRIMARY KEY,
    grupo_id BIGINT NOT NULL,
    usuario_id BIGINT NOT NULL,
    avaliado_por_id BIGINT,
    status status_solicitacao NOT NULL DEFAULT 'PENDENTE',
    data_solicitacao TIMESTAMP NOT NULL DEFAULT now(),
    data_avaliacao TIMESTAMP
);

CREATE TABLE mensagem_grupo (
    id BIGSERIAL PRIMARY KEY,
    grupo_id BIGINT NOT NULL,
    autor_id BIGINT NOT NULL,
    mensagem_respondida_id BIGINT,
    carta_id BIGINT,
    anuncio_id BIGINT,
    tipo_conteudo tipo_conteudo_msg NOT NULL DEFAULT 'TEXTO',
    conteudo TEXT,
    anexo_url VARCHAR(255),
    fixada BOOLEAN NOT NULL DEFAULT false,
    data_envio TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE enquete (
    id BIGSERIAL PRIMARY KEY,
    mensagem_grupo_id BIGINT NOT NULL UNIQUE,
    pergunta VARCHAR(255) NOT NULL,
    multipla_escolha BOOLEAN NOT NULL DEFAULT false,
    encerra_em TIMESTAMP
);

CREATE TABLE opcao_enquete (
    id BIGSERIAL PRIMARY KEY,
    enquete_id BIGINT NOT NULL,
    texto VARCHAR(160) NOT NULL
);

CREATE TABLE voto_enquete (
    opcao_enquete_id BIGINT NOT NULL,
    usuario_id BIGINT NOT NULL,
    data_voto TIMESTAMP NOT NULL DEFAULT now(),
    PRIMARY KEY (opcao_enquete_id, usuario_id)
);

-- ===== 5 - CHAT PESSOAL =====

CREATE TABLE conversa (
    id BIGSERIAL PRIMARY KEY,
    anuncio_id BIGINT,
    data_criacao TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE participante_conversa (
    conversa_id BIGINT NOT NULL,
    usuario_id BIGINT NOT NULL,
    data_entrada TIMESTAMP NOT NULL DEFAULT now(),
    PRIMARY KEY (conversa_id, usuario_id)
);

CREATE TABLE mensagem (
    id BIGSERIAL PRIMARY KEY,
    conversa_id BIGINT NOT NULL,
    autor_id BIGINT NOT NULL,
    mensagem_respondida_id BIGINT,
    conteudo TEXT,
    anexo_url VARCHAR(255),
    lida BOOLEAN NOT NULL DEFAULT false,
    data_leitura TIMESTAMP,
    data_envio TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE bloqueio_usuario (
    id BIGSERIAL PRIMARY KEY,
    bloqueador_id BIGINT NOT NULL,
    bloqueado_id BIGINT NOT NULL,
    data_bloqueio TIMESTAMP NOT NULL DEFAULT now(),
    UNIQUE (bloqueador_id, bloqueado_id)
);

-- ===== 6 - MARKETPLACE (ANUNCIOS, PEDIDOS, AVALIACOES) =====

CREATE TABLE anuncio (
    id BIGSERIAL PRIMARY KEY,
    vendedor_id BIGINT NOT NULL,
    carta_id BIGINT NOT NULL,
    estado_conservacao_id BIGINT,
    preco NUMERIC(10,2) NOT NULL,
    quantidade_disponivel INTEGER NOT NULL DEFAULT 1,
    descricao TEXT,
    status status_anuncio NOT NULL DEFAULT 'ATIVO',
    data_criacao TIMESTAMP NOT NULL DEFAULT now(),
    data_atualizacao TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE foto_anuncio (
    id BIGSERIAL PRIMARY KEY,
    anuncio_id BIGINT NOT NULL,
    url VARCHAR(255) NOT NULL,
    ordem SMALLINT NOT NULL DEFAULT 0
);

CREATE TABLE proposta (
    id BIGSERIAL PRIMARY KEY,
    anuncio_id BIGINT NOT NULL,
    comprador_id BIGINT NOT NULL,
    valor_ofertado NUMERIC(10,2) NOT NULL,
    mensagem VARCHAR(255),
    status status_proposta NOT NULL DEFAULT 'PENDENTE',
    data_criacao TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE pedido (
    id BIGSERIAL PRIMARY KEY,
    anuncio_id BIGINT NOT NULL,
    comprador_id BIGINT NOT NULL,
    vendedor_id BIGINT NOT NULL,
    endereco_entrega_id BIGINT NOT NULL,
    quantidade INTEGER NOT NULL DEFAULT 1,
    valor_itens NUMERIC(10,2) NOT NULL,
    valor_frete NUMERIC(10,2) NOT NULL DEFAULT 0,
    valor_total NUMERIC(10,2) NOT NULL,
    forma_envio VARCHAR(60) NOT NULL,
    status status_pedido NOT NULL DEFAULT 'AGUARDANDO_PAGAMENTO',
    data_pedido TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE pagamento (
    id BIGSERIAL PRIMARY KEY,
    pedido_id BIGINT NOT NULL UNIQUE,
    metodo metodo_pagamento NOT NULL,
    valor NUMERIC(10,2) NOT NULL,
    status status_pagamento NOT NULL DEFAULT 'PENDENTE',
    gateway_referencia VARCHAR(120),
    data_atualizacao TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE avaliacao (
    id BIGSERIAL PRIMARY KEY,
    pedido_id BIGINT NOT NULL UNIQUE,
    autor_id BIGINT NOT NULL,
    vendedor_id BIGINT NOT NULL,
    nota SMALLINT NOT NULL,
    comentario VARCHAR(500),
    data_criacao TIMESTAMP NOT NULL DEFAULT now()
);

-- ===== 7 - NOTIFICACOES E FAVORITOS =====

CREATE TABLE favorito (
    id BIGSERIAL PRIMARY KEY,
    usuario_id BIGINT NOT NULL,
    tipo tipo_favorito NOT NULL,
    album_id BIGINT,
    carta_id BIGINT,
    grupo_id BIGINT,
    data_criacao TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE alerta_preco (
    id BIGSERIAL PRIMARY KEY,
    usuario_id BIGINT NOT NULL,
    carta_id BIGINT NOT NULL,
    preco_alvo NUMERIC(10,2) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT true,
    data_criacao TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE notificacao_global (
    id BIGSERIAL PRIMARY KEY,
    admin_id BIGINT NOT NULL,
    titulo VARCHAR(120) NOT NULL,
    conteudo VARCHAR(500) NOT NULL,
    total_destinatarios INTEGER NOT NULL DEFAULT 0,
    data_disparo TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE notificacao (
    id BIGSERIAL PRIMARY KEY,
    usuario_id BIGINT NOT NULL,
    notificacao_global_id BIGINT,
    titulo VARCHAR(120) NOT NULL,
    mensagem VARCHAR(500) NOT NULL,
    tipo VARCHAR(40) NOT NULL,
    link_referencia VARCHAR(255),
    lida BOOLEAN NOT NULL DEFAULT false,
    data_criacao TIMESTAMP NOT NULL DEFAULT now()
);

-- ===== 8 - MODERACAO E ADMINISTRACAO =====

CREATE TABLE denuncia (
    id BIGSERIAL PRIMARY KEY,
    denunciante_id BIGINT NOT NULL,
    moderador_id BIGINT,
    anuncio_id BIGINT,
    usuario_alvo_id BIGINT,
    mensagem_grupo_id BIGINT,
    tipo_alvo tipo_alvo_denuncia NOT NULL,
    motivo VARCHAR(90) NOT NULL,
    descricao VARCHAR(500),
    status status_denuncia NOT NULL DEFAULT 'PENDENTE',
    data_criacao TIMESTAMP NOT NULL DEFAULT now(),
    data_resolucao TIMESTAMP
);

CREATE TABLE solicitacao_cadastro (
    id BIGSERIAL PRIMARY KEY,
    solicitante_id BIGINT NOT NULL,
    avaliado_por_id BIGINT,
    carta_id BIGINT,
    album_id BIGINT,
    tipo tipo_solic_cadastro NOT NULL,
    dados JSONB NOT NULL,
    status status_solicitacao NOT NULL DEFAULT 'PENDENTE',
    data_criacao TIMESTAMP NOT NULL DEFAULT now(),
    data_avaliacao TIMESTAMP
);

CREATE TABLE log_auditoria (
    id BIGSERIAL PRIMARY KEY,
    admin_id BIGINT NOT NULL,
    acao VARCHAR(90) NOT NULL,
    entidade_afetada VARCHAR(60) NOT NULL,
    entidade_id BIGINT,
    detalhes JSONB,
    data_registro TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE configuracao_global (
    id BIGSERIAL PRIMARY KEY,
    atualizado_por_id BIGINT,
    chave VARCHAR(90) NOT NULL UNIQUE,
    valor TEXT NOT NULL,
    descricao VARCHAR(255),
    data_atualizacao TIMESTAMP NOT NULL DEFAULT now()
);

-- ---------------------------------------------------------------------
-- CHAVES ESTRANGEIRAS
-- ---------------------------------------------------------------------
ALTER TABLE perfil ADD CONSTRAINT fk_perfil_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuario (id);
ALTER TABLE endereco ADD CONSTRAINT fk_endereco_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuario (id);
ALTER TABLE token_recuperacao_senha ADD CONSTRAINT fk_token_recuperacao_senha_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuario (id);
ALTER TABLE usuario_conquista ADD CONSTRAINT fk_usuario_conquista_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuario (id);
ALTER TABLE usuario_conquista ADD CONSTRAINT fk_usuario_conquista_conquista_id FOREIGN KEY (conquista_id) REFERENCES conquista (id);
ALTER TABLE assinatura ADD CONSTRAINT fk_assinatura_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuario (id);
ALTER TABLE categoria ADD CONSTRAINT fk_categoria_categoria_pai_id FOREIGN KEY (categoria_pai_id) REFERENCES categoria (id);
ALTER TABLE album ADD CONSTRAINT fk_album_categoria_id FOREIGN KEY (categoria_id) REFERENCES categoria (id);
ALTER TABLE carta ADD CONSTRAINT fk_carta_album_id FOREIGN KEY (album_id) REFERENCES album (id);
ALTER TABLE carta ADD CONSTRAINT fk_carta_categoria_id FOREIGN KEY (categoria_id) REFERENCES categoria (id);
ALTER TABLE carta ADD CONSTRAINT fk_carta_raridade_id FOREIGN KEY (raridade_id) REFERENCES raridade (id);
ALTER TABLE carta ADD CONSTRAINT fk_carta_idioma_id FOREIGN KEY (idioma_id) REFERENCES idioma (id);
ALTER TABLE foto_carta ADD CONSTRAINT fk_foto_carta_carta_id FOREIGN KEY (carta_id) REFERENCES carta (id);
ALTER TABLE historico_preco ADD CONSTRAINT fk_historico_preco_carta_id FOREIGN KEY (carta_id) REFERENCES carta (id);
ALTER TABLE colecao ADD CONSTRAINT fk_colecao_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuario (id);
ALTER TABLE album_usuario ADD CONSTRAINT fk_album_usuario_colecao_id FOREIGN KEY (colecao_id) REFERENCES colecao (id);
ALTER TABLE album_usuario ADD CONSTRAINT fk_album_usuario_album_id FOREIGN KEY (album_id) REFERENCES album (id);
ALTER TABLE colecao_carta ADD CONSTRAINT fk_colecao_carta_colecao_id FOREIGN KEY (colecao_id) REFERENCES colecao (id);
ALTER TABLE colecao_carta ADD CONSTRAINT fk_colecao_carta_carta_id FOREIGN KEY (carta_id) REFERENCES carta (id);
ALTER TABLE grupo ADD CONSTRAINT fk_grupo_criador_id FOREIGN KEY (criador_id) REFERENCES usuario (id);
ALTER TABLE membro_grupo ADD CONSTRAINT fk_membro_grupo_grupo_id FOREIGN KEY (grupo_id) REFERENCES grupo (id);
ALTER TABLE membro_grupo ADD CONSTRAINT fk_membro_grupo_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuario (id);
ALTER TABLE solicitacao_grupo ADD CONSTRAINT fk_solicitacao_grupo_grupo_id FOREIGN KEY (grupo_id) REFERENCES grupo (id);
ALTER TABLE solicitacao_grupo ADD CONSTRAINT fk_solicitacao_grupo_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuario (id);
ALTER TABLE solicitacao_grupo ADD CONSTRAINT fk_solicitacao_grupo_avaliado_por_id FOREIGN KEY (avaliado_por_id) REFERENCES usuario (id);
ALTER TABLE mensagem_grupo ADD CONSTRAINT fk_mensagem_grupo_grupo_id FOREIGN KEY (grupo_id) REFERENCES grupo (id);
ALTER TABLE mensagem_grupo ADD CONSTRAINT fk_mensagem_grupo_autor_id FOREIGN KEY (autor_id) REFERENCES usuario (id);
ALTER TABLE mensagem_grupo ADD CONSTRAINT fk_mensagem_grupo_mensagem_respondida_id FOREIGN KEY (mensagem_respondida_id) REFERENCES mensagem_grupo (id);
ALTER TABLE mensagem_grupo ADD CONSTRAINT fk_mensagem_grupo_carta_id FOREIGN KEY (carta_id) REFERENCES carta (id);
ALTER TABLE mensagem_grupo ADD CONSTRAINT fk_mensagem_grupo_anuncio_id FOREIGN KEY (anuncio_id) REFERENCES anuncio (id);
ALTER TABLE enquete ADD CONSTRAINT fk_enquete_mensagem_grupo_id FOREIGN KEY (mensagem_grupo_id) REFERENCES mensagem_grupo (id);
ALTER TABLE opcao_enquete ADD CONSTRAINT fk_opcao_enquete_enquete_id FOREIGN KEY (enquete_id) REFERENCES enquete (id);
ALTER TABLE voto_enquete ADD CONSTRAINT fk_voto_enquete_opcao_enquete_id FOREIGN KEY (opcao_enquete_id) REFERENCES opcao_enquete (id);
ALTER TABLE voto_enquete ADD CONSTRAINT fk_voto_enquete_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuario (id);
ALTER TABLE participante_conversa ADD CONSTRAINT fk_participante_conversa_conversa_id FOREIGN KEY (conversa_id) REFERENCES conversa (id);
ALTER TABLE participante_conversa ADD CONSTRAINT fk_participante_conversa_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuario (id);
ALTER TABLE mensagem ADD CONSTRAINT fk_mensagem_conversa_id FOREIGN KEY (conversa_id) REFERENCES conversa (id);
ALTER TABLE mensagem ADD CONSTRAINT fk_mensagem_autor_id FOREIGN KEY (autor_id) REFERENCES usuario (id);
ALTER TABLE mensagem ADD CONSTRAINT fk_mensagem_mensagem_respondida_id FOREIGN KEY (mensagem_respondida_id) REFERENCES mensagem (id);
ALTER TABLE conversa ADD CONSTRAINT fk_conversa_anuncio_id FOREIGN KEY (anuncio_id) REFERENCES anuncio (id);
ALTER TABLE bloqueio_usuario ADD CONSTRAINT fk_bloqueio_usuario_bloqueador_id FOREIGN KEY (bloqueador_id) REFERENCES usuario (id);
ALTER TABLE bloqueio_usuario ADD CONSTRAINT fk_bloqueio_usuario_bloqueado_id FOREIGN KEY (bloqueado_id) REFERENCES usuario (id);
ALTER TABLE anuncio ADD CONSTRAINT fk_anuncio_vendedor_id FOREIGN KEY (vendedor_id) REFERENCES usuario (id);
ALTER TABLE anuncio ADD CONSTRAINT fk_anuncio_carta_id FOREIGN KEY (carta_id) REFERENCES carta (id);
ALTER TABLE anuncio ADD CONSTRAINT fk_anuncio_estado_conservacao_id FOREIGN KEY (estado_conservacao_id) REFERENCES estado_conservacao (id);
ALTER TABLE foto_anuncio ADD CONSTRAINT fk_foto_anuncio_anuncio_id FOREIGN KEY (anuncio_id) REFERENCES anuncio (id);
ALTER TABLE proposta ADD CONSTRAINT fk_proposta_anuncio_id FOREIGN KEY (anuncio_id) REFERENCES anuncio (id);
ALTER TABLE proposta ADD CONSTRAINT fk_proposta_comprador_id FOREIGN KEY (comprador_id) REFERENCES usuario (id);
ALTER TABLE pedido ADD CONSTRAINT fk_pedido_anuncio_id FOREIGN KEY (anuncio_id) REFERENCES anuncio (id);
ALTER TABLE pedido ADD CONSTRAINT fk_pedido_comprador_id FOREIGN KEY (comprador_id) REFERENCES usuario (id);
ALTER TABLE pedido ADD CONSTRAINT fk_pedido_vendedor_id FOREIGN KEY (vendedor_id) REFERENCES usuario (id);
ALTER TABLE pedido ADD CONSTRAINT fk_pedido_endereco_entrega_id FOREIGN KEY (endereco_entrega_id) REFERENCES endereco (id);
ALTER TABLE pagamento ADD CONSTRAINT fk_pagamento_pedido_id FOREIGN KEY (pedido_id) REFERENCES pedido (id);
ALTER TABLE avaliacao ADD CONSTRAINT fk_avaliacao_pedido_id FOREIGN KEY (pedido_id) REFERENCES pedido (id);
ALTER TABLE avaliacao ADD CONSTRAINT fk_avaliacao_autor_id FOREIGN KEY (autor_id) REFERENCES usuario (id);
ALTER TABLE avaliacao ADD CONSTRAINT fk_avaliacao_vendedor_id FOREIGN KEY (vendedor_id) REFERENCES usuario (id);
ALTER TABLE favorito ADD CONSTRAINT fk_favorito_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuario (id);
ALTER TABLE favorito ADD CONSTRAINT fk_favorito_album_id FOREIGN KEY (album_id) REFERENCES album (id);
ALTER TABLE favorito ADD CONSTRAINT fk_favorito_carta_id FOREIGN KEY (carta_id) REFERENCES carta (id);
ALTER TABLE favorito ADD CONSTRAINT fk_favorito_grupo_id FOREIGN KEY (grupo_id) REFERENCES grupo (id);
ALTER TABLE alerta_preco ADD CONSTRAINT fk_alerta_preco_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuario (id);
ALTER TABLE alerta_preco ADD CONSTRAINT fk_alerta_preco_carta_id FOREIGN KEY (carta_id) REFERENCES carta (id);
ALTER TABLE notificacao ADD CONSTRAINT fk_notificacao_usuario_id FOREIGN KEY (usuario_id) REFERENCES usuario (id);
ALTER TABLE notificacao ADD CONSTRAINT fk_notificacao_notificacao_global_id FOREIGN KEY (notificacao_global_id) REFERENCES notificacao_global (id);
ALTER TABLE notificacao_global ADD CONSTRAINT fk_notificacao_global_admin_id FOREIGN KEY (admin_id) REFERENCES usuario (id);
ALTER TABLE denuncia ADD CONSTRAINT fk_denuncia_denunciante_id FOREIGN KEY (denunciante_id) REFERENCES usuario (id);
ALTER TABLE denuncia ADD CONSTRAINT fk_denuncia_moderador_id FOREIGN KEY (moderador_id) REFERENCES usuario (id);
ALTER TABLE denuncia ADD CONSTRAINT fk_denuncia_anuncio_id FOREIGN KEY (anuncio_id) REFERENCES anuncio (id);
ALTER TABLE denuncia ADD CONSTRAINT fk_denuncia_usuario_alvo_id FOREIGN KEY (usuario_alvo_id) REFERENCES usuario (id);
ALTER TABLE denuncia ADD CONSTRAINT fk_denuncia_mensagem_grupo_id FOREIGN KEY (mensagem_grupo_id) REFERENCES mensagem_grupo (id);
ALTER TABLE solicitacao_cadastro ADD CONSTRAINT fk_solicitacao_cadastro_solicitante_id FOREIGN KEY (solicitante_id) REFERENCES usuario (id);
ALTER TABLE solicitacao_cadastro ADD CONSTRAINT fk_solicitacao_cadastro_avaliado_por_id FOREIGN KEY (avaliado_por_id) REFERENCES usuario (id);
ALTER TABLE solicitacao_cadastro ADD CONSTRAINT fk_solicitacao_cadastro_carta_id FOREIGN KEY (carta_id) REFERENCES carta (id);
ALTER TABLE solicitacao_cadastro ADD CONSTRAINT fk_solicitacao_cadastro_album_id FOREIGN KEY (album_id) REFERENCES album (id);
ALTER TABLE log_auditoria ADD CONSTRAINT fk_log_auditoria_admin_id FOREIGN KEY (admin_id) REFERENCES usuario (id);
ALTER TABLE configuracao_global ADD CONSTRAINT fk_configuracao_global_atualizado_por_id FOREIGN KEY (atualizado_por_id) REFERENCES usuario (id);

