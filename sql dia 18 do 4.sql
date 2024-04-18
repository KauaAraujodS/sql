create database voos;
use voos;

create table if not exists passageiro(
cod_passageiro int primary key,
nome varchar(20) not null,
sobrenome varchar(50)not null,
data_nasc date not null,
nacionalidade varchar(45)not null);

create table if not exists cias_aereas(
id_cia int primary key,
nome varchar(45)not null,
cnpj varchar(45)not null);

create table if not exists reservas(
cod_reserva int primary key,
data_reserva varchar(45)not null,
forma_pagamento enum("dinheir","pix", "credito", "debito")not null,
valor_total decimal(10,2)not null);

create table if not exists aeroportos(
primary key(cod_aeroporto, cod_aeroporto_partida, cod_aeroporto_chegada),
nome varchar(100)not null,
cidade varchar(100)not null,
estado varchar(100)not null,
pais varchar(100)not null,
latitude varchar(50)not null,
longitude varchar(50)not null,
tamanho_pista decimal(20,1) not null
);

create table if not exists voos(
id_voo int,
assento varchar(10),
aero_part int not null,
data_part date not null,
hora_part time not null,
aero_cheg int not null,
data_cheg date not null,
hora_cheg time not null,
aeroave varchar(20) not null,
cia_aerea int not null,
primary key(id_voo,assento),
constraint aerop_voo1 foreign key (aero_part)
 references aeroportos(id_aeroporto),
constraint aerop_voo2 foreign key(aero_cheg)
 references aeroportos(id_aeroporto),
constraint aeron_voo foreign key (aeronave)
 references aeronaves(pfx_aero),
constraint cia_voo foreign key (cia_aerea)
 references cia_aereas(id_cia));

create table if not exists aeronave(
pfx_aero varchar(20) primary key,
modelo varchar(50) not null,
ano_fabr year not null,
fabricante varhar(50) not null,
poltronas int not null,
cia_aerea int not null,
constraint cia_aero foreign key(cia_aerea)
references cia_aereas(id_cia));

create table if not exists voos_reservas
