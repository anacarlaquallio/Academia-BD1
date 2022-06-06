CREATE TABLE FUNCIONARIO (
	cpf CHAR (11),
	nome CHAR (60),
	dataContratacao DATE,
	PRIMARY KEY (cpf)
);

CREATE TABLE FUNCIONARIO_PERSONAL (
	cpfPersonal CHAR (11),
	telefone CHAR (11),
	diploma CHAR (200),
	planoContratacao TEXT,
	PRIMARY KEY (cpfPersonal),
	FOREIGN KEY (cpfPersonal) REFERENCES FUNCIONARIO (cpf) ON DELETE CASCADE
);

CREATE TABLE FUNCIONARIO_SECRETARIA (
	cpfSecretaria CHAR (11),
	email CHAR (60),
	salario REAL,
	capacitacao CHAR (200),
	PRIMARY KEY (cpfSecretaria),
	FOREIGN KEY (cpfSecretaria) REFERENCES FUNCIONARIO (cpf) ON DELETE CASCADE
);

CREATE TABLE CLIENTE (
	cpf CHAR (11),
	nome CHAR (60),
	telefone CHAR (11),
	data DATE,
	PRIMARY KEY (cpf)
);

CREATE TABLE ENDERECO (
	cep INTEGER,
	rua CHAR (50),
	logradouro CHAR (100),
	complemento CHAR (30),
	cpfCliente CHAR (11),
	PRIMARY KEY (cep, cpfCliente),
	FOREIGN KEY (cpfCliente) REFERENCES CLIENTE(cpf) ON DELETE CASCADE
);


CREATE TABLE AVALIACAO_FISICA (
	cod INTEGER AUTO_INCREMENT,
	data DATE,
	descricao CHAR (200),
	cpfPersonal CHAR (11),
	cpfCliente CHAR (11),
	PRIMARY KEY (cod),
	FOREIGN KEY (cpfPersonal) REFERENCES FUNCIONARIO_PERSONAL (cpfPersonal), 
	FOREIGN KEY (cpfCliente) REFERENCES CLIENTE (cpf) 
);

CREATE TABLE FLUXO_CAIXA (
	id INTEGER,
	dataEntrada DATE,
	tipoEntrada CHAR (100),
	valor REAL,
	cpfSecretaria CHAR (11) UNIQUE,
	PRIMARY KEY (id),
	FOREIGN KEY (cpfSecretaria) REFERENCES FUNCIONARIO_SECRETARIA (cpfSecretaria)
);

CREATE TABLE MENSALIDADE (
	cod INTEGER AUTO_INCREMENT,
	valor REAL,
	descricao CHAR (200),
	idFluxoCaixa INTEGER,
	PRIMARY KEY (cod),
	FOREIGN KEY (idFluxoCaixa) REFERENCES FLUXO_CAIXA (id)
);

CREATE TABLE PLANO_TREINO (
	cod INTEGER AUTO_INCREMENT,
	dataIni DATE,
	dataFim DATE,
	descricao TEXT,
	cpfCliente CHAR (11),
	cpfPersonal CHAR (11),
	codMensalidade INTEGER,
	PRIMARY KEY (cod),
	FOREIGN KEY (cpfcliente) REFERENCES CLIENTE (cpf),
	FOREIGN KEY (cpfPersonal) REFERENCES FUNCIONARIO_PERSONAL(cpfPersonal),
	FOREIGN KEY (codMensalidade) REFERENCES MENSALIDADE (cod)
);

CREATE TABLE EXERCICIOS (
	cod INTEGER AUTO_INCREMENT,
	nome CHAR (100),
	descricao CHAR (200),
	modalidade CHAR (30),
	PRIMARY KEY (cod)
);

CREATE TABLE EQUIPAMENTOS (
	cod INTEGER AUTO_INCREMENT,
	designacao CHAR (30),
	quantidade INTEGER,
	PRIMARY KEY (cod)
);

CREATE TABLE PLANO_TREINO_EXERCICIOS (
	codExercicio INTEGER,
	codPlanoTreino INTEGER,
	FOREIGN KEY (codExercicio) REFERENCES EXERCICIOS (cod),
	FOREIGN KEY (codPlanoTreino) REFERENCES PLANO_TREINO (cod)
);

CREATE TABLE EXERCICIOS_EQUIPAMENTOS (
	codExercicio INTEGER,
	codEquipamento INTEGER,
	horario CHAR (10),
	FOREIGN KEY (codExercicio) REFERENCES EXERCICIOS (cod),
	FOREIGN KEY (codEquipamento) REFERENCES EQUIPAMENTOS (cod)
);
