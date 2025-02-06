--Criação
CREATE TABLE IF NOT EXISTS cidade (
id_cidade INTEGER NOT NULL,
nome VARCHAR(50) NOT NULL,
pais VARCHAR(50) NOT NULL,
PRIMARY KEY (id_cidade)
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
id_cidade INTEGER,
id_pessoa INTEGER,
data_viagem DATE,
custo FLOAT,
FOREIGN KEY (id_cidade) REFERENCES cidade (id_cidade),
FOREIGN KEY (id_pessoa) REFERENCES pessoa (id_pessoa)
);

--Povoamento

INSERT INTO cidade (id_cidade, nome, pais)
VALUES
	(1, 'Campinas', 'Brasil'),
	(2, 'Nova York', 'Estados Unidos da América'),
	(3, 'São Paulo', 'Brasil'),
	(7, 'Berlim', 'Alemanha'),
	(5, 'Rio Branco', 'Brasil'),
	(6, 'Imperatriz', 'Brasil'),
	(8, 'Ribeirão Preto', 'Brasil'),
	(9, 'Madri', 'Espanha'),
	(4, 'Barcelona', 'Espanha');

INSERT INTO pessoa (id_pessoa, nome, sobrenome, ano_nascimento, cidade_nasceu, sexo, ano_formacao_superior)
VALUES
	(2, 'André', 'Sousa', 1981, 1, 'M', NULL),
	(3, 'Pedro', 'Dias', 1935, 1, 'M', NULL),
	(7, 'Paulo', 'Batista', 1987, 8, 'M', NULL),
	(14, 'Mike', 'Von', 1971, 7, 'M', NULL),
	(13, 'Clarisse', 'Lopes', 1967, 8, 'F', NULL),
	(15, 'Franscisca', 'Sousa', 1981, 3, 'F', NULL),
	(17, 'Mariane', 'Ramos', 2000, 3, 'F', NULL),
	(20, 'Manuela', 'Andrade', 2010, 5, 'F', NULL),
	(21, 'Ingrid', 'Oliveira', 1960, 6, 'F', NULL),
	(22, 'Emanuel', 'Duarte', 1972, 8, 'M', NULL),
	(25, 'Simone', 'Veloso', 1952, 1, 'F', NULL),
	(34, 'Julio', 'Reis', 1985, 3, 'M', NULL),
	(1, 'Amanda', 'Silva', 1987, 1, 'F', 2013),
	(6, 'José', 'Antunes', 1985, 4, 'M', 2009),
	(10, 'Diego', 'Oliveira', 1993, 3, 'M', 2018),
	(11, 'Antônio', 'Silva', 1950, 4, 'M', 1975),
	(12, 'Josh', 'Smith', 1978, 2, 'M', 2005),
	(16, 'Mayara', 'Santos', 1990, 4, 'F', 2015),
	(50, 'Ana Paula', 'Batista', 1989, 3, 'F', 2014),
	(5, 'Paula', 'Andrade', 1990, 5, 'F', 2013);
	
INSERT INTO viagem (id_pessoa, id_cidade, data_viagem, custo)
VALUES
	(10, 5, '2020-05-01', 2000),
	(1, 2, '2015-10-04', 30000),
	(2, 7, '2018-01-12', 5000),
	(1, 1, '2023-02-10', 2000),
	(7, 3, '2017-03-09', 1500),
	(50, 2, '2022-01-07', 15000),
	(11, 3, '2019-03-31', 2700),
	(20, 2, '2024-05-05', 7000),
	(10, 8, '2021-06-20', 4300);

--Consultas
SELECT * FROM pessoa;

SELECT nome, sobrenome, ano_nascimento
FROM pessoa
WHERE UPPER(sexo) = 'F';

SELECT nome, sobrenome, ano_nascimento
FROM pessoa
WHERE UPPER(sexo) = 'F'
ORDER BY ano_nascimento DESC;

SELECT sexo, nome
FROM pessoa
WHERE ano_nascimento >= 1960
ORDER BY ano_nascimento;

SELECT DISTINCT pais
FROM cidade
ORDER BY pais;

SELECT nome, pais
FROM cidade
WHERE pais NOT IN ('Brasil', 'Alemanha');

SELECT nome, sobrenome
FROM pessoa
WHERE ano_formacao_superior IS NOT NULL
	AND(ano_formacao_superior - ano_nascimento) < 30;

SELECT nome, ano_nascimento
FROM pessoa
ORDER BY ano_nascimento
LIMIT 1;

SELECT nome, sobrenome, ano_nascimento
FROM pessoa
WHERE ano_nascimento BETWEEN 1985 AND 1991;

SELECT * FROM pessoa
WHERE ano_formacao_superior IS NULL;

SELECT nome
FROM pessoa
WHERE ano_nascimento < (
	SELECT ano_nascimento
	FROM pessoa
	WHERE nome = 'Ana Paula'
);

SELECT DISTINCT p.nome, p.sobrenome
FROM pessoa p 
JOIN viagem v ON p.id_pessoa = v.id_pessoa;

SELECT DISTINCT p.nome, p.sobrenome
FROM pessoa p
LEFT JOIN viagem v ON p.id_pessoa = v.id_pessoa
WHERE v.id_pessoa = IS NULL;

SELECT p.nome, c.nome
FROM viagem v
JOIN pessoa p ON p.id_pessoa = v.id_pessoa 
JOIN cidade c ON c.id_cidade = v.id_cidade
ORDER BY v.custo DESC
LIMIT 1;

SELECT p.nome, COUNT(v.id_cidade)
FROM pessoa P
LEFT JOIN viagem v ON p.id_pessoa = v.id_pessoa
GROUP BY p.id_pessoa, p.nome;

SELECT c.nome, COUNT(DISTINCT v.id_pessoa)
FROM cidade c
JOIN viagem v ON c.id_cidade = v.id_cidade
GROUP BY c.id_cidade, c.nome
HAVING COUNT(v.id_cidade) >= 2;