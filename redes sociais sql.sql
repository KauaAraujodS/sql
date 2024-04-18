create database redes_sociais;
use redes_sociais;

create table if not exists usuarios(
id_usuario int primary key,
nome varchar(45) not null,
sobrenome varchar(45) not null,
email varchar(45) not null);

create table if not exists grupos(
id_grupos int primary key,
nome_grupo varchar(45) not null,
descricao text not null);

create table if not exists postagens(
id_post int primary key,
texto text not null,
imagem blob not null,
data_hora datetime not null,
id_usuario int not null,
constraint usu_post foreign key (usuario_id_usuario)
references usuarios(id_usuario));

create table if not exists comentario(
id_coment int primary key,
texto text not null,
datahora datetime not null,
id_usuario int not null,
id_post int not null,
constraint usu_coment foreign key (usuarios_id_usuario)
 references usuarios(id_usuario),
constraint post_coment foreign key (postagens_id_post)
 references postagens(id_post));
 