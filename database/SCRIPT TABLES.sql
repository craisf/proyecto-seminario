
CREATE DATABASE proyecto_seminario;

-- -------------------------------------------------------------------------------------

USE proyecto_seminario;
-- ------------------------------------------------------------------------------------
CREATE TABLE personas
(
	idpersona	INT AUTO_INCREMENT PRIMARY KEY,
	nombre		VARCHAR(50)	NOT NULL,
	apellido		VARCHAR(40) 	NOT NULL,
	celular 		CHAR(9)		NULL,		
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
turnoinicio			TIME  	NOT NULL DEFAULT NOW(),
turnofin				TIME 		NULL,
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
nivelacceso			CHAR(20)	NOT NULL, -- ADMIN/ EMPLEADO
CONSTRAINT fk_idempleado_tusuarios FOREIGN KEY (idempleado) REFERENCES empleados (idempleado),
CONSTRAINT uk_usuario_tusuarios UNIQUE (nombreusuario, claveacceso)
)
ENGINE = INNODB;

-- --------------------------------------------------------------------------------------
CREATE TABLE mesas
(
idmesa			INT AUTO_INCREMENT PRIMARY KEY,
numesa			VARCHAR(20)		NOT NULL,
capacidad		INT 		NOT NULL
)
ENGINE = INNODB;

-- -----------------------------------------------------------------------------------------
CREATE TABLE productos
(
idproducto			INT AUTO_INCREMENT PRIMARY KEY,
nombreproducto		VARCHAR(80)		NOT NULL,
descripcion			VARCHAR(500)	NOT NULL,
precio				DECIMAL(7,2)	NOT NULL,
categoria			VARCHAR(30)		NOT NULL
)
ENGINE = INNODB;

-- ---------------------------------------------------------------------------------------
CREATE TABLE estado_ordenes
(
idestadoorden		INT AUTO_INCREMENT PRIMARY KEY,
estado				VARCHAR(20)
)
ENGINE = INNODB;
-- ---------------------------------------------------------

CREATE TABLE ordenes
(
idorden				INT AUTO_INCREMENT PRIMARY KEY,
idmesa				INT 			NOT NULL,
idempleado 			INT 			NOT NULL,
fechahoraorden	 	DATETIME	 	DEFAULT NOW(),
fechahoraentrega 	DATETIME 	NULL,
idestadoorden		INT 	 		NOT NULL, 	-- pendiente, proceso, entregado
CONSTRAINT fk_idmesa_tordenes FOREIGN KEY (idmesa) REFERENCES mesas (idmesa),
CONSTRAINT fk_idempleado_Tordenes FOREIGN KEY (idempleado) REFERENCES empleados (idempleado),
CONSTRAINT fk_idestadoorden_tordenes FOREIGN KEY (idestadoorden) REFERENCES estado_ordenes (idestadoorden)
)
ENGINE = INNODB;

-- ----------------------------------------------------------------------------------------
CREATE TABLE pagos 
(
idpago			INT AUTO_INCREMENT PRIMARY KEY,
fechahorapago		DATETIME 	NOT NULL DEFAULT NOW(),
totalpagar		DECIMAL(7,2)	NOT NULL
)
ENGINE = INNODB;
-- ------------------------------------
CREATE TABLE DETALLE_ORDENES
(
iddetalle_orden		INT AUTO_INCREMENT PRIMARY KEY,
idorden				INT 	NOT NULL,
idcliente			INT 	NOT NULL,
idproducto			INT 	NOT NULL,
cantidad				INT 	NOT NULL,
idpago				INT   NOT NULL,
CONSTRAINT fk_idorden_TdetalleOrden FOREIGN KEY (idorden) REFERENCES ordenes (idorden),
CONSTRAINT fk_idproducto_TdetalleOrden FOREIGN KEY (idproducto) REFERENCES productos (idproducto),
CONSTRAINT fk_idcliente_tordenes FOREIGN KEY (idcliente) REFERENCES personas (idpersona),
CONSTRAINT fk_idpago_tdetalleOrden FOREIGN KEY(idpago) REFERENCES pagos (idpago)
)
ENGINE = INNODB;
-- ----------------------------


-- ------------------------------------------------------------------------------------------

