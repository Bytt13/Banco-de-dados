CREATE TABLE IF NOT EXISTS cidade (
id_cidade SERIAL PRIMARY KEY,
nome VARCHAR(50) NOT NULL,
pais VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS pessoa (
id_pessoa INTEGER NOT NULL,
nome VARCHAR(50) NOT NULL,
sobrenome VARCHAR(50) NOT NULL,
ano_nascimento INTEGER NOT NULL,
ano_formacao_superior INTEGER,
cidade_nasceu INTEGER NOT NULL,
sexo CHAR(1) NOT NULL,
PRIMARY KEY (id_pessoa),
FOREIGN KEY (cidade_nasceu) REFERENCES cidade (id_cidade)
);

CREATE TABLE IF NOT EXISTS viagem (
id_pessoa INTEGER NOT NULL,
id_cidade SERIAL NOT NULL,
custo FLOAT,
data_viagem DATE,
FOREIGN KEY (id_cidade) REFERENCES cidade (id_cidade),
FOREIGN KEY (id_pessoa) REFERENCES pessoa (id_pessoa)
);

INSERT INTO cidade (nome, pais) VALUES ('VITORIA DA CONQUISTA', 'BRASIL');