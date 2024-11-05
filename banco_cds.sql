CREATE DATABASE DB_CDS;  
USE DB_CDS;  

CREATE TABLE tb_artista(
	pk_cod_art INT AUTO_INCREMENT PRIMARY KEY,
    nome_art VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE tb_gravadora(
	pk_cod_grav INT AUTO_INCREMENT PRIMARY KEY,
    nome_grav VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE tb_categoria(
	pk_cod_cat INT AUTO_INCREMENT PRIMARY KEY,
    nome_cat VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE tb_estado(
	pk_sigla_est CHAR(2) NOT NULL PRIMARY KEY,
    nome_est CHAR(50) NOT NULL UNIQUE
);

CREATE TABLE tb_cidade(
	pk_cod_cid INT AUTO_INCREMENT PRIMARY KEY,
    fk_sigla_est CHAR(2) NOT NULL,
    FOREIGN KEY (fk_sigla_est) REFERENCES tb_estado (pk_sigla_est),
    nome_cid VARCHAR(100) NOT NULL
);

CREATE TABLE tb_cliente(
	pk_cod_cli INT AUTO_INCREMENT PRIMARY KEY,
    fk_cod_cid INT NOT NULL,
    FOREIGN KEY (fk_cod_cid) REFERENCES tb_cidade (pk_cod_cid),
    nome_cli VARCHAR(100) NOT NULL,
    end_cli VARCHAR(200) NOT NULL,
    renda_cli DECIMAL(10,2) NOT NULL DEFAULT(0),
    sexo_cli ENUM('M', 'F') NOT NULL DEFAULT('F')  	
);

CREATE TABLE tb_conjuge(
	pk_fk_cod_cli INT AUTO_INCREMENT PRIMARY KEY,
    nome_conj VARCHAR(100) NOT NULL,
    renda_conj DECIMAL(10,2) NOT NULL DEFAULT(0),
    sexo_conj  ENUM('F', 'M') NOT NULL DEFAULT('M'),
    FOREIGN KEY (pk_fk_cod_cli) REFERENCES tb_cliente (pk_cod_cli)
);

CREATE TABLE tb_funcionario(
	pk_cod_func INT AUTO_INCREMENT PRIMARY KEY,
    nome_func VARCHAR(100) NOT NULL,
    end_func VARCHAR(200) NOT NULL,
    sal_func DECIMAL(10,2) NOT NULL DEFAULT(0),
    sexo_func ENUM('F','M') DEFAULT('M')
);

CREATE TABLE dependente(
	pk_cod_dep INT AUTO_INCREMENT PRIMARY KEY,
    fk_cod_func INT NOT NULL,
    FOREIGN KEY (fk_cod_func) REFERENCES tb_funcionario (pk_cod_func),
    nome_dep VARCHAR(100) NOT NULL,
    sexo_dep ENUM('F', 'M') DEFAULT ('M')
);

CREATE TABLE tb_titulo(
	pk_cod_tit INT AUTO_INCREMENT PRIMARY KEY,
    fk_cod_cat INT NOT NULL,
    FOREIGN KEY (fk_cod_cat) REFERENCES tb_categoria (pk_cod_cat),
    fk_cod_grav INT NOT NULL,
    FOREIGN KEY (fk_cod_grav) REFERENCES tb_gravadora (pk_cod_grav),
    nome_cd VARCHAR(100) NOT NULL UNIQUE,
    val_cd DECIMAL(10,2) NOT NULL,
    qtd_estq INT NOT NULL
);

CREATE TABLE tb_pedido(
	pk_num_ped INT AUTO_INCREMENT PRIMARY KEY,
    fk_cod_cli INT NOT NULL,
    FOREIGN KEY (fk_cod_cli) REFERENCES tb_cliente(pk_cod_cli),
    fk_cod_func INT NOT NULL,
    FOREIGN KEY (fk_cod_func) REFERENCES tb_funcionario(pk_cod_func),
    data_ped DATETIME NOT NULL,
    val_ped DECIMAL(10,2) NOT NULL DEFAULT(0)
);

CREATE TABLE tb_titulo_pedido(
	PRIMARY KEY (fk_num_ped, fk_cod_tit),
    fk_num_ped INT NOT NULL,
	FOREIGN KEY (fk_num_ped) REFERENCES tb_pedido(pk_num_ped),
    fk_cod_tit INT NOT NULL,
    FOREIGN KEY (fk_cod_tit) REFERENCES tb_titulo(pk_cod_tit),
    qtd_cd INT NOT NULL,
    val_cd DECIMAL(10,2) NOT NULL
);

CREATE TABLE tb_titulo_artista(
	PRIMARY KEY (fk_cod_tit, fk_cod_art),
    fk_cod_tit INT NOT NULL,
	FOREIGN KEY (fk_cod_tit) REFERENCES tb_titulo(pk_cod_tit),
    fk_cod_art INT NOT NULL,
    FOREIGN KEY (fk_cod_art) REFERENCES tb_artista(pk_cod_art)
);
