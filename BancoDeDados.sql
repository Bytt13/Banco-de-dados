CREATE TABLE IF NOT EXISTS Usuario(
	id_user INT NOT NULL,
	PRIMARY KEY(id_user),
	nome_user VARCHAR(50) NOT NULL,
	sobrenome VARCHAR(60) NOT NULL,
	email_user VARCHAR(120) NOT NULL,
	idade INT NOT NULL,
	apelido_no_sistema VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Amigo_de(
	id_user INT,
	id_amigo INT NOT NULL,
	PRIMARY KEY (id_user, id_amigo),
	FOREIGN KEY (id_user) REFERENCES Usuario(id_user),
	FOREIGN KEY (id_amigo) REFERENCES Usuario(id_user)
);

CREATE TABLE IF NOT EXISTS jogador(
	id_jogador INT NOT NULL,
	PRIMARY KEY (id_jogador),
	FOREIGN KEY (id_jogador) REFERENCES Usuario(id_user)
);

CREATE TABLE IF NOT EXISTS Mestre (
	id_mestre INT NOT NULL,
	PRIMARY KEY (id_mestre),
	FOREIGN KEY (id_mestre) REFERENCES Usuario(id_user)
);

CREATE TABLE IF NOT EXISTS Sistema_RPG (
	id_sistema INT NOT NULL,
	PRIMARY KEY (id_sistema),
	nome_sistema VARCHAR(80) NOT NULL,
	tipo_dado VARCHAR(50) NOT NULL,
	descricao VARCHAR(300) NOT NULL
);

CREATE TABLE IF NOT EXISTS Preferencia (
	id_user INT,
	id_sistema INT,
	nivel_exp_usuario INT NOT NULL,
	PRIMARY KEY (id_user, id_sistema),
	FOREIGN KEY (id_user) REFERENCES Usuario(id_user),
	FOREIGN KEY (id_sistema) REFERENCES Sistema_RPG(id_sistema)
);

CREATE TABLE IF NOT EXISTS Post(
	id_post INT NOT NULL,
	descricao VARCHAR(300),
	id_user INT,
	PRIMARY KEY (id_user, id_post),
	FOREIGN KEY (id_user) REFERENCES Usuario(id_user)
);

CREATE TABLE IF NOT EXISTS Mesa(
	id_mesa INT NOT NULL,
	PRIMARY KEY (id_mesa),
	nome_mesa VARCHAR(60) NOT NULL,
	descricao_mesa VARCHAR(100),
	id_mestre_mesa INT NOT NULL,
	id_sistema_mesa INT NOT NULL,
	FOREIGN KEY (id_mestre_mesa) REFERENCES Mestre(id_mestre),
	FOREIGN KEY (id_sistema_mesa) REFERENCES Sistema_RPG(id_sistema)
);

CREATE TABLE IF NOT EXISTS Participa(
	id_mesa INT,
	id_jogador INT,
	PRIMARY KEY (id_mesa, id_jogador),
	FOREIGN KEY (id_mesa) REFERENCES Mesa(id_mesa),
	FOREIGN KEY (id_jogador) REFERENCES Jogador(id_jogador)
);

CREATE TABLE IF NOT EXISTS Sessao(
	id_sessao INT NOT NULL,
	data_sessao DATE NOT NULL,
	hora_inicio VARCHAR(10) NOT NULL,
	hora_fim VARCHAR(10) NOT NULL,
	id_mesa INT,
	PRIMARY KEY (id_sessao, id_mesa),
	FOREIGN KEY (id_mesa) REFERENCES Mesa(id_mesa)
);

CREATE TABLE IF NOT EXISTS FeedBack(
	id_sessao INT,
	id_mesa INT,
	id_jogador INT,
	avaliacao INT NOT NULL,
	descricao_feedback VARCHAR(120) NOT NULL,
	PRIMARY KEY (id_sessao, id_jogador, id_mesa),
	FOREIGN KEY (id_sessao, id_mesa) REFERENCES Sessao(id_sessao, id_mesa),
	FOREIGN KEY (id_jogador) REFERENCES Jogador(id_jogador)
);

CREATE TABLE IF NOT EXISTS Sistema_de_Usuario(
	id_sistema INT, 
	id_mestre INT,
	PRIMARY KEY (id_sistema, id_mestre),
	FOREIGN KEY (id_sistema) REFERENCES Sistema_RPG(id_sistema),
	FOREIGN KEY (id_mestre) REFERENCES Mestre(id_mestre)
);

CREATE TABLE IF NOT EXISTS Sistema_Preexistente(
	id_sistema INT, 
	PRIMARY KEY (id_sistema),
	nome_livro VARCHAR(60) NOT NULL,
	editora VARCHAR(60) NOT NULL,
	sistema VARCHAR(60) NOT NULL,
	FOREIGN KEY (id_sistema) REFERENCES Sistema_RPG(id_sistema)
);

CREATE TABLE IF NOT EXISTS Ficha_Personagem(
	id_ficha INT NOT NULL,
	nome_personagem VARCHAR(50) NOT NULL,
	habilidades VARCHAR (1000) NOT NULL,
	descricao_personagem VARCHAR(600) NOT NULL,
	id_user INT,
	PRIMARY KEY (id_ficha, id_user),
	FOREIGN KEY (id_user) REFERENCES Usuario(id_user)
);

CREATE TABLE IF NOT EXISTS Usa_Ficha(
	id_sessao INT,
	id_user INT,
	id_mesa INT,
	id_ficha INT,
	PRIMARY KEY (id_sessao, id_ficha, id_mesa, id_user),
	FOREIGN KEY (id_sessao, id_mesa) REFERENCES Sessao(id_sessao, id_mesa),
	FOREIGN KEY (id_ficha, id_user) REFERENCES Ficha_Personagem(id_ficha, id_user)
);
