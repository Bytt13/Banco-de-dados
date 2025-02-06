CREATE TABLE IF NOT EXISTS departamento (
    d_numero SERIAL NOT NULL,
    d_nome VARCHAR(20) NOT NULL,
    cpf_ger NUMERIC(11,0),
    dt_inicio_ger DATE,
    PRIMARY KEY (d_numero)
);

CREATE TABLE IF NOT EXISTS empregado (
    cpf NUMERIC(11,0) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    iniciais_meio VARCHAR(3),
    sobrenome VARCHAR(50),
    dt_nascimento DATE,
    sexo CHARACTER(1),
    salario FLOAT,
    cpf_super NUMERIC(11,0),
    d_num INTEGER,
    PRIMARY KEY (cpf),
    FOREIGN KEY (cpf_super) REFERENCES empregado(cpf),
    FOREIGN KEY (d_num) REFERENCES departamento(d_numero)
);

CREATE TABLE IF NOT EXISTS projeto (
    p_numero SERIAL NOT NULL,
    p_nome VARCHAR(20),
    d_num INTEGER,
    p_localizacao VARCHAR(50),
    PRIMARY KEY (p_numero),
    FOREIGN KEY (d_num) REFERENCES departamento(d_numero)
);

CREATE TABLE IF NOT EXISTS dependente (
    e_cpf NUMERIC(11,0) NOT NULL,
    dep_nome VARCHAR(50) NOT NULL,
    sexo CHARACTER(1),
    dt_nascimento DATE,
    parentesco VARCHAR(20),
    PRIMARY KEY (e_cpf, dep_nome),
    FOREIGN KEY (e_cpf) REFERENCES empregado(cpf),
    CHECK (sexo IN ('M', 'F', 'm', 'f'))
);

CREATE TABLE IF NOT EXISTS trabalha_em (
    p_num INTEGER NOT NULL,
    e_cpf NUMERIC(11,0) NOT NULL,
    hora FLOAT,
    PRIMARY KEY (p_num, e_cpf),
    FOREIGN KEY (e_cpf) REFERENCES empregado(cpf),
    FOREIGN KEY (p_num) REFERENCES projeto(p_numero)
);

CREATE TABLE IF NOT EXISTS localizacao_dep (
    d_num INTEGER NOT NULL,
    localizacao VARCHAR(20) NOT NULL,
    PRIMARY KEY (d_num, localizacao),
    FOREIGN KEY (d_num) REFERENCES departamento(d_numero)
);

ALTER TABLE departamento 
ADD FOREIGN KEY (cpf_ger) REFERENCES empregado(cpf);

-- Inserções na tabela empregado
INSERT INTO empregado (cpf, nome, iniciais_meio, sobrenome, dt_nascimento, sexo, salario, cpf_super)
VALUES 
    (123456789, 'JOHN', 'B', 'SMITH', '1965-09-01', 'M', 30000, NULL),
    (333445555, 'FRANKLIN', 'T', 'WOND', '1955-08-12', 'M', 40000, NULL),
    (999887777, 'ALICIA', 'J', 'ZELAYA', '1968-07-19', 'F', 25000, NULL),
    (987654321, 'JENNFFER', 'S', 'WALLACE', '1941-06-20', 'F', 43000, NULL),
    (666894444, 'RAMESH', 'K', 'NARAYAN', '1962-09-15', 'M', 38000, NULL),
    (453453453, 'JOYCE', 'A', 'ENGLISH', '1972-07-31', 'F', 25000, NULL),
    (987987987, 'AHMAD', 'V', 'JABBAR', '1969-03-29', 'M', 25000, NULL),
    (888665555, 'JAMES', 'E', 'BORG', '1937-11-10', 'M', 55000, NULL);

-- Atualizações na tabela empregado
UPDATE empregado SET cpf_super = 333445555 WHERE cpf = 123456789;
UPDATE empregado SET cpf_super = 888665555 WHERE cpf = 333445555;
UPDATE empregado SET cpf_super = 987654321 WHERE cpf = 999887777;
UPDATE empregado SET cpf_super = 888665555 WHERE cpf = 987654321;
UPDATE empregado SET cpf_super = 333445555 WHERE cpf = 666894444;
UPDATE empregado SET cpf_super = 333445555 WHERE cpf = 453453453;
UPDATE empregado SET cpf_super = 987654321 WHERE cpf = 987987987;
UPDATE empregado SET cpf_super = NULL WHERE cpf = 888665555;

-- Inserções na tabela departamento
INSERT INTO departamento (d_nome, d_numero, cpf_ger, dt_inicio_ger)
VALUES
    ('COMPUTACAO', 1, 333445555, '1998-05-22'),
    ('ADMINISTRACAO', 2, 987654321, '1995-01-01'),
    ('COORDENACAO', 3, 888665555, '1981-06-19');

-- Inserções na tabela trabalha_em
INSERT INTO trabalha_em (e_cpf, p_num, hora)
VALUES
    (123456789, 1, 32.5),
    (123456789, 2, 7.5),
    (666894444, 3, 40.0),
    (453453453, 1, 20.0),
    (453453453, 2, 20.0),
    (333445555, 2, 10.0),
    (333445555, 3, 10.0),
    (333445555, 10, 10.0),
    (333445555, 20, 10.0),
    (999887777, 30, 30.0),
    (999887777, 10, 10.0),
    (987987987, 10, 35.0),
    (987987987, 30, 5.0),
    (987654321, 30, 20.0),
    (987654321, 20, 15.0),
    (888665555, 20, NULL);

-- Inserções na tabela localizacao_dep
INSERT INTO localizacao_dep (d_num, localizacao)
VALUES
    (1, 'HOUSTON'),
    (2, 'STAFFORD'),
    (3, 'BELLAIRE'),
    (3, 'SUGARLAND'),
    (3, 'HOUSTON');

-- Inserções na tabela dependente
INSERT INTO dependente (e_cpf, dep_nome, sexo, dt_nascimento, parentesco)
VALUES
    (333445555, 'ALICE', 'F', '1986-04-05', 'FILHA'),
    (333445555, 'THEODORE', 'M', '1983-10-25', 'FILHO'),
    (333445555, 'JOY', 'F', '1958-05-03', 'ESPOSA'),
    (987654321, 'ABNER', 'M', '1942-02-28', 'ESPOSO'),
    (123456789, 'MICHAEL', 'M', '1986-01-04', 'FILHO'),
    (123456789, 'ALICE', 'F', '1988-12-30', 'FILHA'),
    (123456789, 'ELIZABETH', 'F', '1967-05-05', 'ESPOSA');

-- Inserções na tabela projeto
INSERT INTO projeto (p_nome, p_localizacao, p_numero, d_num)
VALUES
    ('PRODUTO X', 'BELLAIRE', 1, 1),
    ('PRODUTO Y', 'SUGARLAND', 2, 1),
    ('PRODUTO Z', 'HOUSTON', 3, 1),
    ('INFORMATIZACAO', 'STAFFORD', 10, 2),
    ('REORGANIZACAO', 'HOUSTON', 20, 3),
    ('NOVOS BENEFICIOS', 'STAFFORD', 30, 2);

SELECT nome || ' ' || COALESCE(iniciais_meio || ' ', '') || sobrenome AS nome_completo
FROM empregado
WHERE sexo = 'M'
ORDER BY nome_completo;

SELECT p_nome, p_num
FROM projeto
WHERE p_localizacao = 'STAFFORD';

SELECT dep_nome, sexo
FROM dependente;

SELECT d.dep_nome
FROM dependente d
JOIN empregado e ON d.e_cpf = e.cpf
WHERE e.nome = 'JOHN' AND e.sobrenome = 'SMITH';

SELECT DISTINCT e.nome
FROM empregado e
JOIN dependente d ON e.cpf = d.e_cpf
WHERE e.nome = d.dep_nome;

SELECT e.nome
FROM empregado e
JOIN empregado s ON e.cpf_super = s.cpf
WHERE s.nome = 'FRANKLIN' AND s.sobrenome = 'WONG';

SELECT e.nome AS empregado_nome, p.p_nome AS projeto_nome
FROM empregado e
JOIN trabalha_em te ON e.cpf = te.e_cpf
JOIN projeto p ON te.p_num = p.p_numero;

SELECT nome
FROM empregado
WHERE cpf NOT IN (SELECT e_cpf FROM trabalha_em);
