DROP DATABASE IF EXISTS proyecto_seminario ;
CREATE DATABASE proyecto_seminario;
USE proyecto_seminario;

CREATE TABLE personas
(
	idpersona	INT AUTO_INCREMENT PRIMARY KEY,
	nombre		VARCHAR(50)	NULL,
	apellido		VARCHAR(40) NULL,
	celular 		CHAR(9)		NULL,		
	correo		VARCHAR(60)	NULL,	
	direccion	VARCHAR(80)	NULL,
	tipodoc		CHAR(20)		NULL DEFAULT 'DNI', -- D = DNI  
	numerodoc	CHAR(12)		NULL
)
ENGINE  = INNODB;


CREATE TABLE empleados
(
idempleado			INT AUTO_INCREMENT PRIMARY KEY 	NOT NULL,
idpersona			INT 		NOT NULL,
nombrerol			CHAR(20)	NOT NULL, -- RECEPCIONISTA
turnoinicio			TIME  	NOT NULL DEFAULT NOW(),
turnofin				TIME 		NULL,
CONSTRAINT fk_idpersona_templeados FOREIGN KEY (idpersona) REFERENCES personas (idpersona),
CONSTRAINT uk_idpersona_templeados UNIQUE (idpersona)
)
ENGINE = INNODB;


CREATE TABLE usuarios
(
idusuario			INT AUTO_INCREMENT PRIMARY KEY,
idempleado			INT 		NOT NULL,
nombreusuario		VARCHAR(30)	NOT NULL,	
claveacceso			VARCHAR(100)	NOT NULL,
nivelacceso			CHAR(20)	NOT NULL, -- ADMIN/ EMPLEADO
CONSTRAINT fk_idempleado_tusuarios FOREIGN KEY (idempleado) REFERENCES empleados (idempleado),
CONSTRAINT uk_usuario_tusuarios UNIQUE (nombreusuario, claveacceso)
)
ENGINE = INNODB;


CREATE TABLE mesas
(
idmesa			INT AUTO_INCREMENT PRIMARY KEY,
numesa			VARCHAR(20)		NOT NULL,
capacidad		INT 		NOT NULL,
estado			VARCHAR(20)	NULL DEFAULT ('DISPONIBLE') -- OCUPADO - DISPONIBLE  
)
ENGINE = INNODB;


CREATE TABLE productos
(
idproducto			INT AUTO_INCREMENT PRIMARY KEY,
nombreproducto		VARCHAR(80)		NOT NULL,
descripcion			VARCHAR(500)	NOT NULL,
precio				DECIMAL(7,2)	NOT NULL,
categoria			VARCHAR(30)		NOT NULL
)
ENGINE = INNODB;


CREATE TABLE ordenes
(
idorden				INT AUTO_INCREMENT PRIMARY KEY,
idmesa				INT 			NOT NULL,
idempleado 			INT 			NULL,
idcliente			INT 			NULL,
fechahoraorden	 	DATETIME	 	DEFAULT NOW(),
fechahorapago	 	DATETIME 	NULL,
tipocomprobante	CHAR(2)		NULL, -- BS / BE
numcomprobante		CHAR(9)		NULL,
estado 				CHAR(5)		NULL, -- PEN / ENT
preciototal			DECIMAL(7,2) NULL,
CONSTRAINT fk_idmesa_tordenes FOREIGN KEY (idmesa) REFERENCES mesas (idmesa),
CONSTRAINT fk_idempleado_Tordenes FOREIGN KEY (idempleado) REFERENCES empleados (idempleado),
CONSTRAINT fk_idcliente_Tordenes FOREIGN KEY (idcliente) REFERENCES personas (idpersona)
)
ENGINE = INNODB;



CREATE TABLE DETALLE_ORDENES
(
iddetalle_orden	INT AUTO_INCREMENT PRIMARY KEY,
idorden				INT 	NOT NULL,
idproducto			INT 	NOT NULL,
cantidad				INT 	NOT NULL,
CONSTRAINT fk_idorden_TdetalleOrden FOREIGN KEY (idorden) REFERENCES ordenes (idorden),
CONSTRAINT fk_idproducto_TdetalleOrden FOREIGN KEY (idproducto) REFERENCES productos (idproducto)
)
ENGINE = INNODB;


