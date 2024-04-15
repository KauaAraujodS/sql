create database if not exists CLINICA;
use CLINICA;
create table if not exists medico(
id_medico int primary key,
crm int not null,
nome varchar(100) not null,
cpf varchar(20) not null,
especialidade varchar(50) not null,
data_nascimento date not null,
endereço varchar(200) not null,
telefone varchar(20));

create table if not exists cargo(
id_cargo int primary key,
nome varchar(45)not null);

create table if not exists riscos_ocupacionais(
id_riscos int primary key,
nome varchar(45) not null);

create table if not exists resultado_exame(
id_tipo_resultado_exame int primary key,
tipo varchar(30) not null);

create table if not exists tipo_exame(
id_tipo_exame int primary key,
tipo varchar(50) not null);

create table if not exists atestado(
id_atestado int primary key,
resultado_riscos varchar(100) not null,
resultado varchar(100) not null,
observacoes varchar(300) not null,
medico int not null,
constraint med_atest foreign key(medico) references
medico(id_medico));

create table if not exists exame(
id_exame int primary key,
especialidade varchar(50) not null,
data_realizacao date not null,
tipo_exame int not null,
constraint tip_exm foreign key(tipo_exame) references
tipo_exame(id_tipo_exame),
resultado_exame int not null,
constraint res_exm foreign key(resultado_exame) references
resultado_exame(id_tipo_resultado_exame));

create table if not exists empresa(
id_empresa int primary key,
cnpj varchar(20) not null,
nome_fantasia varchar(50) not null,
endereco varchar(200) not null,
telefone varchar(20) not null,
empresa int not null,
constraint emp_emp foreign key(empresa) references
empresa(id_empresa));

create table if not exists funcionario(
id_funcionario int primary key,
nome varchar(100) not null,
cpf varchar(20) not null,
data_nascimento date not null,
endereco varchar(200) not null,
telefone varchar(20) not null,
cargo int not null,
constraint carg_func foreign key(cargo) references
cargo(id_cargo),
empresa int not null,
constraint emp_func foreign key(empresa) references
empresa(id_empresa));

create table if not exists exame_has_atestado(
exame int not null,
atestado int not null,
primary key(exame, atestado),
constraint exam_ats foreign key(exame) references
exame(id_exame),
constraint ates_exam foreign key(atestado) references
atestado(id_atestado));

create table if not exists empresa_has_exame(
exame int not null,
empresa int not null,
primary key(exame,empresa),
constraint exam_emp foreign key(exame) references
exame(id_exame),
constraint emp_exam foreign key(empresa) references
empresa(id_empresa));

create table if not exists funcionario_has_exame(
exame int not null,
funcionario int not null,
primary key(exame, funcionario),
constraint funci_exam foreign key(funcionario) references
funcionario(id_funcionario),
constraint exam_func foreign key(exame) references
exame(id_exame));

create table if not exists cargo_has_riscos_ocupacionais(
cargo int not null,
risco int not null,
primary key(cargo, riscos),
constraint carg_risc foreign key(cargo) references
cargo(id_cargo),
constraint risc_carg foreign key(risco_ocupacionais) references
risco_ocupacionais(id_riscos));







