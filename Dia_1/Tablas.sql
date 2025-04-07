-- Database: dia_1

-- DROP DATABASE IF EXISTS dia_1;

CREATE DATABASE dia_1
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'es-CO'
    LC_CTYPE = 'es-CO'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE fabricante (
	codigo SERIAL PRIMARY KEY,
	nombre varchar(100) NOT NULL
);

CREATE TABLE producto (
	codigo SERIAL PRIMARY KEY,
	nombre varchar(100) NOT NULL,
	precio DOUBLE PRECISION NOT NULL, 
	codigo_fabricante INT,
	FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);