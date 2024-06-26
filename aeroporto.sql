CREATE DATABASE IF NOT EXISTS PASSAGENS_AEREAS;
USE PASSAGENS_AEREAS;

CREATE TABLE IF NOT EXISTS PASSAGEIROS(
COD_PASSAGEIRO INT PRIMARY KEY,
NOME VARCHAR(100) NOT NULL,
SOBRENOME VARCHAR(100) NOT NULL,
DATA_NASC DATE NOT NULL,
NACIONALIDADE VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS AEROPORTOS(
ID_AEROPORTO INT PRIMARY KEY,
NOME VARCHAR(100) NOT NULL,
CIDADE VARCHAR(100) NOT NULL,
ESTADO VARCHAR(100) NOT NULL,
PAIS VARCHAR(100) NOT NULL,
LATITUDE VARCHAR(50) NOT NULL,
LONGITUDE VARCHAR(50) NOT NULL,
TAMANHO_PISTA DECIMAL(20,1) NOT NULL
);

CREATE TABLE IF NOT EXISTS CIA_AEREAS(
ID_CIA INT PRIMARY KEY,
CNPJ VARCHAR(20) NOT NULL,
NOME_FANTASIA VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS RESERVAS(
ID_RESERVA INT PRIMARY KEY,
DATA_RESERVA DATE NOT NULL,
FORMA_PGTO ENUM("DINHEIRO","PIX","DEBITO","CREDITO") NOT NULL,
VALOR_RESERVA DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS AERONAVES(
PFX_AERO VARCHAR(20) PRIMARY KEY,
MODELO VARCHAR(50) NOT NULL,
ANO_FABR YEAR NOT NULL,
FABRICANTE VARCHAR(50) NOT NULL,
POLTRONAS INT NOT NULL,
CIA_AEREA INT NOT NULL,
CONSTRAINT CIA_AERO FOREIGN KEY(CIA_AEREA) REFERENCES CIA_AEREAS(ID_CIA));

CREATE TABLE IF NOT EXISTS VOOS(
ID_VOO INT,
ASSENTO VARCHAR(10),
AERO_PART INT NOT NULL,
DATA_PART DATE NOT NULL,
HORA_PART TIME NOT NULL,
AERO_CHEG INT NOT NULL,
DATA_CHEG DATE NOT NULL,
HORA_CHEG TIME NOT NULL,
AERONAVE VARCHAR(20) NOT NULL,
CIA_AEREA INT NOT NULL,
PRIMARY KEY(ID_VOO,ASSENTO),
CONSTRAINT AEROP_VOO1 FOREIGN KEY(AERO_PART) REFERENCES AEROPORTOS(ID_AEROPORTO),
CONSTRAINT AEROP_VOO2 FOREIGN KEY(AERO_CHEG) REFERENCES AEROPORTOS(ID_AEROPORTO),  
CONSTRAINT AERON_VOO FOREIGN KEY(AERONAVE) REFERENCES AERONAVES(PFX_AERO),
CONSTRAINT CIA_VOO FOREIGN KEY(CIA_AEREA) REFERENCES CIA_AEREAS(ID_CIA)
);

CREATE TABLE IF NOT EXISTS VOOS_RESERVAS(
ID_VOO INT,
ASSENTO VARCHAR(10),
ID_RESERVA INT,
PRIMARY KEY(ID_VOO,ASSENTO,ID_RESERVA),
CONSTRAINT VR1 FOREIGN KEY(ID_VOO,ASSENTO) REFERENCES VOOS(ID_VOO,ASSENTO),
CONSTRAINT VR2 FOREIGN KEY(ID_RESERVA) REFERENCES RESERVAS(ID_RESERVA)
);

CREATE TABLE IF NOT EXISTS PASSAGEIROS_RESERVAS(
PASSAGEIRO INT,
ID_RESERVA INT,
PRIMARY KEY(PASSAGEIRO,ID_RESERVA),
CONSTRAINT PR1 FOREIGN KEY(PASSAGEIRO) REFERENCES PASSAGEIROS(COD_PASSAGEIRO),
CONSTRAINT PR2 FOREIGN KEY(ID_RESERVA) REFERENCES RESERVAS(ID_RESERVA));

INSERT INTO aeronaves
(PFX_AERO,
MODELO,
ANO_FABR,
FABRICANTE,
POLTRONAS,
CIA_AEREA)
VALUES
("1111AA","boeing177","1765","boeing","50","AZUL"),
("2222BB","boeing177","1920","boeing","100","GOL"),
("3333CC","boeing177","1865","boeing","75","LATAM"),
("4444DD","boeing177","2023","boeing","100","GOL"),
("5555DD","boeing177","2000","boeing","50","AZUL");

INSERT INTO aeroportos
(ID_AEROPORTO,
NOME,
CIDADE,ESTADO,
PAIS,
LATITUDE,
LONGITUDE,
TAMANHO_PISTA)
VALUES
(1,"SANTOS DUMMONT","RIO DE JANEIRO","RJ","BRASIL","203217-2354235","4567358-543535","3KM"),
(2,"GALEAO","RIO DE JANEIRO","RJ","BRASIL","32423746-17641","2875684342-34234453","4KM"),
(3,"JUSCELINO KUBSCHEKER","SAO PAULO","SP","BRASIL","87543543-1247361523","4567358-543535","2KM"),
(4,"KLEBER ANDRADE","VITORIA","ES","BRASIL","20EW7-235424235","4534358-543535","3KM"),
(5,"ALBERT EISTEIN","VENEZA","FDS","ITALIA","203217-2354235","4567358-543535","4KM");

INSERT INTO cia_aereas
(ID_CIA,CNPJ,NOME_FANTASIA)
VALUES
(1,"1-343.414.432","perdroca"),
(2,"2-343.414.432","frkjf"),
(3,"3-343.414.432","khkgdsa"),
(4,"4-343.414.432","fdfdsfsd"),
(5,"5-343.414.432","dsadwdsf");

INSERT INTO passageiros
(COD_PASSAGEIRO,
NOME,
SOBRENOME,
DATA_NASC,
NACIONALIDADE)
VALUES
(4325-53,"xxxxxxx","yyyyy4y","11/11/41","br"),
(5235-99,"xxxxxxx","yyy6yyy","11/11/55","br"),
(4325-53,"xxxcxx","yyyyyyy","16/11/11","br"),
(4325-53,"xxxxvxx","yyyytyy","11/4/11","br"),
(4325-53,"xnxxxxx","yyyygyy","11/6/11","br");

INSERT INTO passageiros_reservas
(PASSAGEIRO,
ID_RESERVA)
VALUES
("43","1"),
("44","2"),
("50","3"),
("32","4"),
("10","4");

INSERT INTO reservas
(ID_RESERVA,
DATA_RESERVA,
FORMA_PGTO,
VALOR_RESERVA)
VALUES
("1",11/11/11,"credito","R$12345"),
("2",22/22/22,"pix","R$143245"),
("3",33/33/33,"debito","R$145"),
("4",44/44/44,"boleto","R$432"),
("5",55/55/55,"pics","R$43246");
INSERT INTO voos
(ID_VOO,
ASSENTO,
AERO_PART,
DATA_PART,
HORA_PART,
AERO_CHEG,
DATA_CHEG,
HORA_CHEG,
AERONAVE,
CIA_AEREA)
VALUES
("1111","45","111","11/11/11","11:11","22","22/22/22","22:22","4325","GOL"),
("2222","46","222","22/22/22","22:22","33","33/33/33","22:21","455","GOL"),
("3333","47","333","33/33/33","33:33","44","44/44/33","22:25","4625","GOL"),
("4444","48","444","44/44/44","44:44","55","22/22/42","22:24","4365","GOL"),
("5555","49","555","55/55/55","55:55","66","22/22/25","22:12","4375","GOL");

INSERT INTO voos_reservas
(ID_VOO,
ASSENTO,
ID_RESERVA)
VALUES
("1","1","1"),
("2","2","2"),
("3","3","3"),
("4","4","4"),
("5","5","5");





