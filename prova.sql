CREATE TABLE IF NOT EXISTS curso (
	cod_curso INTEGER NOT NULL,
	PRIMARY KEY (cod_curso),
	nome_curso VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS alunos (
	cod_aluno INTEGER NOT NULL,
	PRIMARY KEY(cod_aluno),
	cod_curso INTEGER,
	FOREIGN KEY (cod_curso) REFERENCES curso (cod_curso),
	nome_aluno VARCHAR(50) NOT NULL,
	endereco_aluno VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS departamento (
	cod_departamento VARCHAR(5) NOT NULL,
	PRIMARY KEY (cod_departamento),
	nome_departamento VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS disciplina (
	cod_disciplina VARCHAR(7) NOT NULL,
	PRIMARY KEY (cod_disciplina),
	cod_departamento VARCHAR (5),
	FOREIGN KEY (cod_departamento) REFERENCES departamento (cod_departamento),
	nome_disciplina VARCHAR(45) NOT NULL,
	credito INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS curriculo (
	cod_curso INTEGER NOT NULL,
	FOREIGN KEY (cod_curso) REFERENCES curso (cod_curso),
	cod_disciplina VARCHAR(7),
	FOREIGN KEY (cod_disciplina) REFERENCES disciplina (cod_disciplina),
	tipo VARCHAR(12) NOT NULL
);

CREATE TABLE IF NOT EXISTS conceito (
	periodo VARCHAR(7) NOT NULL,
	PRIMARY KEY (periodo),
	cod_aluno INTEGER,
	FOREIGN KEY (cod_aluno) REFERENCES alunos(cod_aluno),
	cod_disciplina VARCHAR(7),
	FOREIGN KEY (cod_disciplina) REFERENCES disciplina (cod_disciplina),
	nota FLOAT
);

INSERT INTO curso (cod_curso, nome_curso) VALUES
	(01, 'Ciência da Computação'),
	(02, 'Física'),
	(03, 'Matemática'),
	(04, 'Educação Física'),
	(05, 'Letras');


INSERT INTO alunos (cod_aluno, nome_aluno, cod_curso, endereco_aluno) VALUES
	(1, 'Carlos Braga', 01, 'Rua A'),
	(2, 'Fernando Santana', 01, 'Rua A'),
	(3, 'Augusto Fontes', 02, 'Rua A'),
	(4, 'Helder Santos', 03, 'Rua A'),
	(5, 'Vinícius Cardoso', 03, 'Rua A'),
	(6, 'Alvaro Silva', 04, 'Rua A'),
	(7, 'Mariana Carvalho', 05, 'Rua A'),
	(8, 'Valeria Gonzaga', 01, 'Rua A');

INSERT INTO departamento (cod_departamento, nome_departamento) VALUES
	(1, 'DCET'),
	(2, 'DCH'),
	(3, 'DEF'),
	(4, 'DQ');
	
INSERT INTO disciplina (cod_disciplina, nome_disciplina, credito, cod_departamento) VALUES
	('CC101', 'Linguagem de programação 1', 06, 1),
	('CC102', 'Linguagem de programação 2', 04, 1),
	('CC103', 'Estrutura de Dados', 06, 1),
	('CC201', 'Banco de Dados 1', 05, 1),
	('Mat101', 'Cálculo 1', 04, 1),
	('Mat102', 'Cálculo 2', 04, 1),
	('Fis101', 'Física mecânica', 04, 1),
	('Fis103', 'Física Elétrica', 04, 1),
	('Let301', 'Português instrumental ', 04, 2),
	('Efi444', 'Natação', 02, 3);

ALTER TABLE conceito
ADD nota FLOAT;

INSERT INTO conceito (cod_aluno, cod_disciplina, periodo, nota) VALUES
	(1, 'CC201', '2001-2', 9.0),
	(2, 'CC201', '2002-2', 8.5),
	(5, 'CC201', '2000-2', 7.2),
	(2, 'CC101', '2004-1', 8.1),
	(7, 'Let301', '1999-1', 7.6),
	(8, 'Fis101', '2003-2', 8.0),
	(2, 'Fis101', '2000-1', 7.4);

INSERT INTO curriculo (cod_curso, cod_disciplina, tipo) VALUES
	(01, 'CC101', 'Obrigatória'),
	(01, 'CC102', 'Obrigatória'),
	(01, 'CC103', 'Obrigatória'),
	(01, 'CC201', 'Obrigatória'),
	(03, 'CC201', 'Opcional'),
	(03, 'Mat101', 'Obrigatória'),
	(03, 'Mat102', 'Obrigatória'),
	(05, 'Fis101', 'Opcional'),
	(05, 'Fis103', 'Opcional'),
	(05, 'Let301', 'Obrigatória'),
	(02, 'Efi444', 'Opcional');

--SELECT nome_aluno, cod_aluno FROM alunos; - OK

--SELECT nome_aluno, cod_aluno FROM alunos WHERE cod_curso = 1; - OK

--SELECT * FROM disciplina WHERE nome_disciplina = 'Banco de Dados 1';

--SELECT alunos.nome_aluno, curso.nome_curso FROM alunos JOIN curso ON alunos.cod_curso = curso.cod_curso; - OK

--SELECT nome_aluno FROM alunos WHERE cod_curso = (SELECT cod_curso FROM curso WHERE nome_curso = 'Ciência da Computação'); - OK

--SELECT nome_disciplina FROM disciplina ORDER BY nome_disciplina ASC;

--SELECT disciplina.nome_disciplina, disciplina.cod_disciplina
--FROM ((disciplina JOIN curriculo ON disciplina.cod_disciplina = curriculo.cod_disciplina) JOIN curso ON curso.cod_curso = curriculo.cod_curso)
--WHERE nome_curso = 'Ciência da Computação';

SELECT alunos.nome_aluno
FROM ((alunos JOIN conceito ON alunos.cod_aluno = conceito.cod_aluno) JOIN disciplina ON conceito.cod_disciplina = disciplina.cod_disciplina)
WHERE disciplina.nome_disciplina = 'Banco de Dados 1'
