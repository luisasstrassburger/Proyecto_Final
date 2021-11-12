--Creación tabla de usuarios
create table usuarios (
	usuario_id numeric(4,0) constraint pk_usuarios primary key,
	genero varchar(20),
	edad numeric(2,0) not null,
	estado_republica varchar(30) not null,
	estudiante boolean not null
);

create sequence usuarios_id_usuario_seq start 1 increment 1;
alter table usuarios alter column usuario_id
set default nextval('usuarios_id_usuario_seq');


--Creación tabla perfil_usuario que contiene la información de las preguntas generales
create table perfil_usuario (
	perfil_usuario_id numeric(4) constraint pk_perfil_usuario primary key,
	usuario_id numeric(4) references usuarios (usuario_id) not null,
	internet_casa boolean not null,
	dispositivo_fav numeric(4) references dispositivos (dispositivo_id) not null,
	tiempo_dia numeric(3,2) not null,
	tipo_conexion varchar(50)
);

create sequence perfil_usuario_id_perfil_usuario_seq start 1 increment 1;
alter table perfil_usuario alter column perfil_usuario_id
set default nextval('perfil_usuario_id_perfil_usuario_seq');

create table perfil_confianza (
	perfil_usuario_id numeric(4) references perfil_usuario (perfil_usuario_id) on update cascade,
	confianza_id numeric(4) references confianza (confianza_id) on update cascade,
	constraint pk_perfil_confianza primary key (perfil_usuario_id, confianza_id)
);

alter table perfil_confianza add column valor numeric(1) not null;

create table confianza (
	confianza_id numeric(4) constraint pk_confianza primary key,
	rubro varchar(50) not null
);

create sequence confianza_id_confianza_seq start 1 increment 1;
alter table confianza alter column confianza_id
set default nextval('confianza_id_confianza_seq');

create table no_compras_razones(
	razones_id numeric(4) constraint pk_no_compras_razones primary key,
	descripcion varchar(80) not null
);

create sequence razones_id_razones_seq start 1 increment 1;
alter table no_compras_razones alter column razones_id
set default nextval('razones_id_razones_seq');

create table e_commerce (
	e_commerce_id numeric(4) constraint pk_e_commerce primary key,
	usuario_id numeric(4) references usuarios (usuario_id) not null,
	porcentaje_compras numeric(3,2) not null,
	frecuencia varchar(50) not null,
	dato_evitar_compra boolean,
	razones_id numeric(4) references no_compras_razones (razones_id)
);

create sequence e_commerce_id_e_commerce_seq start 1 increment 1;
alter table e_commerce alter column e_commerce_id
set default nextval('e_commerce_id_e_commerce_seq');

create sequence dispositivos_id_dispositivos_seq start 1 increment 1;
alter table dispositivos alter column dispositivo_id
set default nextval('dispositivos_id_dispositivos_seq');

create table dispositivos_usuarios (
	dispositivo_id numeric(4) references dispositivos (dispositivo_id) on update cascade,
	usuario_id numeric(4) references usuarios (usuario_id) on update cascade,
	constraint pk_dispositivos_usuarios primary key (dispositivo_id, usuario_id)
);

alter table dispositivos add column nombre varchar(50) not null;
	
create table area_estudio (
	area_estudio_id numeric(4) constraint pk_area_estudio primary key,
	descripcion varchar(50) not null
);

create sequence area_estudio_id_area_estudio_seq start 1 increment 1;
alter table area_estudio alter column area_estudio_id
set default nextval('area_estudio_id_area_estudio_seq');

alter table usuarios add column area_estudio_id numeric(4) references area_estudio(area_estudio_id);

create table permisos (
	permiso_id numeric(4) constraint pk_permisos primary key,
	descripcion varchar(50) not null
);

create sequence permisos_id_permisos_seq start 1 increment 1;
alter table permisos alter column permiso_id
set default nextval('permisos_id_permisos_seq');

create table perfil_permiso (
	perfil_usuario_id numeric(4) references perfil_usuario (perfil_usuario_id) on update cascade,
	permiso_id numeric(4) references permisos (permiso_id) on update cascade,
	constraint pk_perfil_permiso primary key (perfil_usuario_id, permiso_id)
);

alter table perfil_usuario add column antivirus boolean;



create table apps_web (
	apps_web_id numeric(4) constraint pk_apps_web primary key,
	usuario_id numeric(4) references usuarios (usuario_id) not null,
	saber_cookies boolean not null,
	aceptar_cookies varchar(50) not null,
	leer_terminos varchar(50) not null,
	aceptar_terminos varchar(50) not null
);
	
create sequence apps_web_id_apps_web_seq start 1 increment 1;
alter table apps_web alter column apps_web_id
set default nextval('apps_web_id_apps_web_seq');

create table apps_web_confianza (
	apps_web_id numeric(4) references apps_web (apps_web_id) on update cascade,
	confianza_id numeric(4) references confianza (confianza_id) on update cascade,
	constraint pk_apps_web_confianza primary key (apps_web_id, confianza_id)
);

create table situaciones (
	situacion_id numeric(4) constraint pk_situaciones primary key,
	descripcion varchar(50) not null
);

create sequence situaciones_seq start 1 increment 1;
alter table situaciones alter column situacion_id
set default nextval('situaciones_seq');

create table apps_web_situaciones (
	apps_web_id numeric(4) references apps_web (apps_web_id) on update cascade,
	situacion_id numeric(4) references situaciones (situacion_id) on update cascade,
	constraint pk_apps_web_situaciones primary key (apps_web_id, situacion_id)
);

create table redes (
	--Esta tabla es para enlistar nombres de redes sociales
	red_id numeric(4) constraint pk_redes primary key,
	descripcion varchar(50) not null
);

create sequence redes_seq start 1 increment 1;
alter table redes alter column red_id
set default nextval('redes_seq');

alter table apps_web_confianza add column valor numeric(1) not null;

create table social_media (
	social_media_id numeric(4) constraint pk_social_media primary key,
	usuario_id numeric(4) references usuarios (usuario_id) not null,
	redes_abiertas_cerradas boolean not null,
	uso_historial varchar(50) not null
);
	
create sequence social_media_seq start 1 increment 1;
alter table social_media alter column social_media_id
set default nextval('social_media_seq');

create table social_media_redes (
	social_media_id numeric(4) references social_media (social_media_id) on update cascade,
	red_id numeric(4) references redes (red_id) on update cascade,
	constraint pk_social_media_redes primary key (social_media_id, red_id)
);

create table social_media_confianza (
	social_media_id numeric(4) references social_media (social_media_id) on update cascade,
	confianza_id numeric(4) references confianza (confianza_id) on update cascade,
	constraint pk_social_media_confianza primary key (social_media_id, confianza_id)
);

create table formas_pago (
	forma_pago_id numeric(4) constraint pk_formas_pago primary key,
	nombre varchar(4) not null
);

create sequence formas_pago_seq start 1 increment 1;
alter table formas_pago alter column forma_pago_id
set default nextval('formas_pago_seq');

alter table e_commerce add column forma_pago_id numeric(4) references formas_pago (forma_pago_id) not null;

alter table e_commerce add column paypal_increase boolean not null;

create table escalares_e_commerce (
	escalares_e_commerce_id numeric(4) constraint pk_escalares_e_commerce primary key,
	descripcion varchar(50) not null
);

create sequence escalares_e_commerce_seq start 1 increment 1;
alter table escalares_e_commerce alter column escalares_e_commerce_id
set default nextval('escalares_e_commerce_seq');

create table valoracion_e_comerce (
	e_commerce_id numeric(4) references e_commerce (e_commerce_id) on update cascade,
	escalares_e_commerce_id numeric(4) references escalares_e_commerce (escalares_e_commerce_id) on update cascade,
	constraint pk_valoracion_e_comerce primary key (e_commerce_id, escalares_e_commerce_id)
);


drop table apps_web_confianza ;
drop table social_media_confianza ;
drop table confianza ;
drop table escalares_apps_web;

create table escalares_apps_web (
	escalares_apps_web_id numeric(4) constraint pk_escalares_apps_web primary key,
	descripcion varchar(50) not null
);

create sequence escalares_apps_web_seq start 1 increment 1;
alter table escalares_apps_web alter column escalares_apps_web_id
set default nextval('escalares_apps_web_seq');

create table valoracion_apps_web (
	apps_web_id numeric(4) references apps_web (apps_web_id) on update cascade,
	escalares_apps_web_id numeric(4) references escalares_apps_web (escalares_apps_web_id) on update cascade,
	constraint pk_valoracion_apps_web primary key (apps_web_id, escalares_apps_web_id)
);
alter table valoracion_apps_web add column valor numeric(1) not null;

create table escalares_social_media (
	escalares_social_media_id numeric(4) constraint pk_escalares_social_media primary key,
	descripcion varchar(50) not null
);

create sequence escalares_social_media_seq start 1 increment 1;
alter table escalares_social_media alter column escalares_social_media_id
set default nextval('escalares_social_media_seq');

create table valoracion_social_media (
	social_media_id numeric(4) references social_media (social_media_id) on update cascade,
	escalares_social_media_id numeric(4) references escalares_social_media (escalares_social_media_id) on update cascade,
	valor numeric(1) not null,
	constraint pk_valoracion_social_media primary key (social_media_id, escalares_social_media_id)
);













	