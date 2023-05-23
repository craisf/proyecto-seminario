
CREATE DATABASE proyecto_seminario

-- -------------------------------------------------------------------------------------

USE proyecto_seminario

-- ------------------------------------------------------------------------------------

CREATE TABLE personas
(
	idpersona	INT AUTO_INCREMENT PRIMARY KEY,
	nombre		VARCHAR(50)	NOT NULL,
	apellido	VARCHAR(40) 	NOT NULL,
	celular 	CHAR(9)		NULL,		
	correo		VARCHAR(60)	NULL,	
	direccion	VARCHAR(80)	NULL,
	tipodoc		CHAR(20)	NOT NULL DEFAULT 'DNI', -- D = DNI / C = CARNET EXTRANJERIA 
	numerodoc	CHAR(12)	NOT NULL
)
ENGINE  = INNODB;

-- ------------------------------------------------------------------------------------

CREATE TABLE empleados
(
idempleado			INT AUTO_INCREMENT PRIMARY KEY 	NOT NULL,
idpersona			INT 		NOT NULL,
nombrerol			CHAR(20)	NOT NULL, -- MAITRE / MESERO / CHEF / RECEPCIONISTA
turnoinicio			TIME  		NOT NULL DEFAULT NOW(),
turnofin			TIME 		NULL,
CONSTRAINT fk_idpersona_templeados FOREIGN KEY (idpersona) REFERENCES personas (idpersona),
CONSTRAINT uk_idpersona_templeados UNIQUE (idpersona)
)
ENGINE = INNODB;

-- -------------------------------------------------------------------------------------

CREATE TABLE usuarios
(
idusuario			INT AUTO_INCREMENT PRIMARY KEY,
idempleado			INT 		NOT NULL,
nombreusuario		 	VARCHAR(30)	NOT NULL,	
claveacceso			VARCHAR(100)	NOT NULL,
nivelacceso			CHAR(20)	NOT NULL, -- ADMIN/ CLIENT / HOST
CONSTRAINT fk_idempleado_tusuarios FOREIGN KEY (idempleado) REFERENCES empleados (idempleado),
CONSTRAINT uk_usuario_tusuarios UNIQUE (nombreusuario, claveacceso)
)
ENGINE = INNODB;

-- --------------------------------------------------------------------------------------

CREATE TABLE mesas
(
idmesa			INT AUTO_INCREMENT PRIMARY KEY,
numesa			INT 		NOT NULL,
capacidad		INT 		NOT NULL
)
ENGINE = INNODB;

-- -----------------------------------------------------------------------------------------

CREATE TABLE productos
(
idproducto			INT AUTO_INCREMENT PRIMARY KEY,
nombreproducto			VARCHAR(80)		NOT NULL,
descripcion			VARCHAR(90)		NOT NULL,
precio				DECIMAL(7,2)		NOT NULL,
categoria			VARCHAR(30)		NOT NULL
)
ENGINE = INNODB;

-- ---------------------------------------------------------------------------------------

CREATE TABLE ordenes
(
idorden			INT AUTO_INCREMENT PRIMARY KEY,
idmesa			INT 			NOT NULL,
idempleado 		INT 			NOT NULL,
idcliente		INT 			NOT NULL,
fechahoraorden	 	DATETIME	 	DEFAULT NOW(),
estado			CHAR(30) 		NOT NULL, 	-- pendiente, en proceso, entregada
CONSTRAINT fk_idmesa_tordenes FOREIGN KEY (idmesa) REFERENCES mesas (idmesa),
CONSTRAINT fk_idempleado_tordenes FOREIGN KEY (idempleado) REFERENCES empleados (idempleado),
CONSTRAINT fk_idcliente_tordenes FOREIGN KEY (idcliente) REFERENCES personas (idpersona)
)
ENGINE = INNODB;

-- ----------------------------------------------------------------------------------------

CREATE TABLE DETALLE_ORDENES
(
iddetalle_orden		INT AUTO_INCREMENT PRIMARY KEY,
idorden			INT 	NOT NULL,
idproducto		INT 	NOT NULL,
cantidad		INT 	NOT NULL,
CONSTRAINT fk_idorden_TdetalleOrden FOREIGN KEY (idorden) REFERENCES ordenes (idorden),
CONSTRAINT fk_idproducto_TdetalleOrden FOREIGN KEY (idproducto) REFERENCES productos (idproducto)
)
ENGINE = INNODB;

-- ------------------------------------------------------------------------------------------

CREATE TABLE pagos 
(
idpago			INT AUTO_INCREMENT PRIMARY KEY,
idorden			INT 		NOT NULL,
fechahorapago		DATETIME 	NOT NULL,
totalpagar		DECIMAL(7,2)	NOT NULL,
CONSTRAINT fk_idorden_tpagos FOREIGN KEY (idorden) REFERENCES ordenes (idorden)
)
ENGINE = INNODB;
-- ----------------------------------------------------------------------------------------