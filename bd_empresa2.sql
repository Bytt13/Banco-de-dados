-- SCHEMA: empresa

-- DROP SCHEMA IF EXISTS empresa ;

CREATE SCHEMA IF NOT EXISTS empresa
    AUTHORIZATION postgres;

	CREATE TABLE if not exists departamento
(
    d_numero serial NOT NULL,
    d_nome varchar(20) NOT NULL,
    cpf_ger numeric(11,0),
    dt_inicio_ger date,
    PRIMARY KEY (d_numero)
);

CREATE TABLE if not exists empregado
(
    cpf numeric(11,0) NOT NULL,
    nome varchar (50) NOT NULL,
    iniciais_meio varchar (3),
    sobrenome varchar (50),
    dt_nascimento date,
    sexo character(1) ,
    salario float, 
    cpf_super numeric(11,0),
    d_num integer,
    PRIMARY KEY (cpf),
    FOREIGN KEY (cpf_super) REFERENCES empregado (cpf),
    FOREIGN KEY (d_num) REFERENCES departamento (d_numero) 
);

CREATE TABLE if not exists projeto
(
    p_numero serial NOT NULL,
    p_nome varchar(20),
    d_num integer,
    p_localizacao varchar(50) COLLATE pg_catalog."default",
    PRIMARY KEY (p_numero),
    FOREIGN KEY (d_num) REFERENCES departamento (d_numero)
);

CREATE TABLE if not exists dependente
(
    e_cpf numeric(11,0) NOT NULL,
    dep_nome varchar(50) NOT NULL,
    sexo character(1),
    dt_nascimento date,
    parentesco varchar(20),
    PRIMARY KEY (e_cpf, dep_nome),
    FOREIGN KEY (e_cpf) REFERENCES empregado (cpf),
    CHECK (sexo in ('M', 'F', 'm', 'f'))
);

CREATE TABLE if not exists trabalha_em
(
    p_num integer NOT NULL,
    e_cpf numeric(11,0) NOT NULL,
    hora float,
    PRIMARY KEY (p_num, e_cpf),
    FOREIGN KEY (e_cpf) REFERENCES empregado (cpf),
    FOREIGN KEY (p_num) REFERENCES projeto (p_numero)
);

CREATE TABLE if not exists localizacao_dep
(
    d_num integer NOT NULL,
    localizacao varchar (20) NOT NULL,
    PRIMARY KEY (d_num, localizacao),
    FOREIGN KEY (d_num) REFERENCES departamento (d_numero)
);


alter table departamento add FOREIGN KEY (cpf_ger) REFERENCES empregado (cpf);


