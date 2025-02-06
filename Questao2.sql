-- SCHEMA: pedido

-- DROP SCHEMA IF EXISTS pedido ;

CREATE SCHEMA IF NOT EXISTS pedido
    AUTHORIZATION postgres;

	CREATE TABLE if not exists cliente
	(
		cod_cliente integer NOT NULL,
		nome_cliente varchar(50) NOT NULL,
		endereco_cliente varchar(60) NOT NULL,
		PRIMARY KEY (cod_cliente)
	);

	CREATE TABLE if not exists vendedor
	(
		cod_vendedor integer NOT NULL,
		nome_vendedor varchar(50) NOT NULL,
		endereco_vendedor varchar(60) NOT NULL,
		PRIMARY KEY (cod_vendedor)
	);

	CREATE TABLE if not exists pedidos
	(
		cod_pedido integer NOT NULL,
		cod_vendedor integer,
		cod_cliente integer,
		FOREIGN KEY (cod_vendedor) REFERENCES vendedor (cod_vendedor),
		FOREIGN KEY (cod_cliente) REFERENCES cliente (cod_cliente),
		data_pedido date,
		qtde_pedido float,
		valor_pedido float,
		PRIMARY KEY (cod_pedido)
	);

	CREATE TABLE if not exists linha_produto
	(
		cod_linha integer NOT NULL,
		descricao_linha varchar(255),
		PRIMARY KEY (cod_linha)
	);

	CREATE TABLE if not exists produto
	(
		cod_produto integer NOT NULL,
		cod_linha integer,
		FOREIGN KEY (cod_linha) REFERENCES linha_produto(cod_linha),
		nome_produto varchar(60) NOT NULL,
		qtde_produto float,
		PRIMARY KEY (cod_produto)
	);

	CREATE TABLE if not exists item
	(
		qtde_item float,
		valor_unit float,
		valor_parcial float,
		cod_produto integer, 
		cod_pedido integer,
		FOREIGN KEY (cod_produto) REFERENCES produto (cod_produto),
		FOREIGN KEY (cod_pedido) REFERENCES pedidos (cod_pedido)
	);