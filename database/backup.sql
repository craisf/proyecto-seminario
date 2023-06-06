/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 10.4.27-MariaDB : Database - proyecto_seminario
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`proyecto_seminario` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `proyecto_seminario`;

/*Table structure for table `detalle_ordenes` */

DROP TABLE IF EXISTS `detalle_ordenes`;

CREATE TABLE `detalle_ordenes` (
  `iddetalle_orden` int(11) NOT NULL AUTO_INCREMENT,
  `idorden` int(11) NOT NULL,
  `idproducto` int(11) NOT NULL,
  `precio` decimal(7,2) NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`iddetalle_orden`),
  KEY `fk_idorden_TdetalleOrden` (`idorden`),
  KEY `fk_idproducto_TdetalleOrden` (`idproducto`),
  CONSTRAINT `fk_idorden_TdetalleOrden` FOREIGN KEY (`idorden`) REFERENCES `ordenes` (`idorden`),
  CONSTRAINT `fk_idproducto_TdetalleOrden` FOREIGN KEY (`idproducto`) REFERENCES `productos` (`idproducto`),
  CONSTRAINT `fk_cantidad_tdetalleOrden` CHECK (`cantidad` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `detalle_ordenes` */

insert  into `detalle_ordenes`(`iddetalle_orden`,`idorden`,`idproducto`,`precio`,`cantidad`) values 
(1,1,4,8.99,1),
(2,1,13,14.99,1),
(3,1,3,14.99,1),
(4,1,14,13.99,1),
(5,2,8,8.99,1),
(6,2,12,7.99,3),
(7,3,4,8.99,1),
(8,4,7,12.99,5);

/*Table structure for table `empleados` */

DROP TABLE IF EXISTS `empleados`;

CREATE TABLE `empleados` (
  `idempleado` int(11) NOT NULL AUTO_INCREMENT,
  `idpersona` int(11) NOT NULL,
  `nombrerol` char(20) NOT NULL,
  `turnoinicio` time NOT NULL DEFAULT current_timestamp(),
  `turnofin` time DEFAULT NULL,
  PRIMARY KEY (`idempleado`),
  UNIQUE KEY `uk_idpersona_templeados` (`idpersona`),
  CONSTRAINT `fk_idpersona_templeados` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `empleados` */

insert  into `empleados`(`idempleado`,`idpersona`,`nombrerol`,`turnoinicio`,`turnofin`) values 
(1,1,'RECEPCIONISTA','17:34:08',NULL),
(2,2,'MESERO','17:34:08',NULL),
(3,3,'MESERO','17:34:08',NULL),
(4,4,'MESERO','17:34:08',NULL);

/*Table structure for table `mesas` */

DROP TABLE IF EXISTS `mesas`;

CREATE TABLE `mesas` (
  `idmesa` int(11) NOT NULL AUTO_INCREMENT,
  `numesa` varchar(20) NOT NULL,
  `capacidad` tinyint(4) NOT NULL,
  `estado` char(1) DEFAULT 'D',
  PRIMARY KEY (`idmesa`),
  UNIQUE KEY `uk_numesa_tmesas` (`numesa`),
  CONSTRAINT `ck_estado_tmesas` CHECK (`estado` in ('D','O'))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `mesas` */

insert  into `mesas`(`idmesa`,`numesa`,`capacidad`,`estado`) values 
(1,'Mesa 1',2,'O'),
(2,'Mesa 2',4,'O'),
(3,'Mesa 3',6,'O'),
(4,'Mesa 4',2,'O'),
(5,'Mesa 5',4,'D'),
(6,'Mesa 6',8,'D'),
(7,'Mesa 7',6,'D'),
(8,'Mesa 8',4,'D'),
(9,'Mesa 9',6,'D'),
(10,'Mesa 10',2,'D'),
(11,'Mesa 11',2,'D'),
(12,'Mesa 12',2,'D'),
(13,'Mesa 13',2,'D'),
(14,'Mesa 14',2,'D'),
(15,'Mesa 15',2,'D'),
(16,'Mesa 16',2,'D'),
(17,'Mesa 17',2,'D'),
(18,'Mesa 18',2,'D'),
(19,'Mesa 19',2,'D'),
(20,'Mesa 20',2,'D');

/*Table structure for table `ordenes` */

DROP TABLE IF EXISTS `ordenes`;

CREATE TABLE `ordenes` (
  `idorden` int(11) NOT NULL AUTO_INCREMENT,
  `idmesa` int(11) NOT NULL,
  `idempleado` int(11) DEFAULT NULL,
  `idcliente` int(11) DEFAULT NULL,
  `fechahoraorden` datetime DEFAULT current_timestamp(),
  `fechahorapago` datetime DEFAULT NULL,
  `tipocomprobante` char(2) DEFAULT NULL,
  `numcomprobante` char(9) DEFAULT NULL,
  `preciototal` decimal(7,2) DEFAULT NULL,
  `estado` char(2) DEFAULT 'PE',
  PRIMARY KEY (`idorden`),
  KEY `fk_idmesa_tordenes` (`idmesa`),
  KEY `fk_idempleado_Tordenes` (`idempleado`),
  KEY `fk_idcliente_Tordenes` (`idcliente`),
  CONSTRAINT `fk_idcliente_Tordenes` FOREIGN KEY (`idcliente`) REFERENCES `personas` (`idpersona`),
  CONSTRAINT `fk_idempleado_Tordenes` FOREIGN KEY (`idempleado`) REFERENCES `empleados` (`idempleado`),
  CONSTRAINT `fk_idmesa_tordenes` FOREIGN KEY (`idmesa`) REFERENCES `mesas` (`idmesa`),
  CONSTRAINT `ck_tipocomprobante_tordenes` CHECK (`tipocomprobante` in ('BS','BE')),
  CONSTRAINT `ck_preciototal_tordenes` CHECK (`preciototal` = (`preciototal` > 0)),
  CONSTRAINT `ck_estado_tordenes` CHECK (`estado` in ('PE','EN'))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ordenes` */

insert  into `ordenes`(`idorden`,`idmesa`,`idempleado`,`idcliente`,`fechahoraorden`,`fechahorapago`,`tipocomprobante`,`numcomprobante`,`preciototal`,`estado`) values 
(1,1,1,NULL,'2023-06-06 17:37:42',NULL,NULL,NULL,NULL,'PE'),
(2,2,1,NULL,'2023-06-06 17:38:09',NULL,NULL,NULL,NULL,'PE'),
(3,3,2,NULL,'2023-06-06 17:38:19',NULL,NULL,NULL,NULL,'PE'),
(4,4,4,NULL,'2023-06-06 17:38:26',NULL,NULL,NULL,NULL,'PE');

/*Table structure for table `personas` */

DROP TABLE IF EXISTS `personas`;

CREATE TABLE `personas` (
  `idpersona` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `celular` char(9) DEFAULT NULL,
  `correo` varchar(60) DEFAULT NULL,
  `direccion` varchar(80) DEFAULT NULL,
  `dni` char(9) DEFAULT 'DNI',
  PRIMARY KEY (`idpersona`),
  UNIQUE KEY `uk_dni_tpersonas` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `personas` */

insert  into `personas`(`idpersona`,`nombre`,`apellido`,`celular`,`correo`,`direccion`,`dni`) values 
(1,'Carlos ','Moran ','956321478','carlos@gmail.com','Santa Rosa','71594314'),
(2,'María','López ','912345678','maria.lopez@gmail.com','Calle 123, Ciudad Ejemplo','12345678'),
(3,'Juan','García ','998765432','juan.garcia@gmail.com',' Avenida Principal, Pueblo Nuevo','75369821'),
(4,'Ana','Rodríguez ','955556231','ana.rodriguez@gmail.com','Calle 456, Urbanización Bella Vista','98765432'),
(5,'Pedro','Martínez ','911561283','pedro.martinez@gmail.com','Avenida Libertad, Barrio Centro','87654321'),
(6,'Laura','Sánchez ','999005208','laura.sanchez@gmail.com','Calle 789, Colonia Esperanza','98765405');

/*Table structure for table `productos` */

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `idproducto` int(11) NOT NULL AUTO_INCREMENT,
  `nombreproducto` varchar(80) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `precio` decimal(7,2) NOT NULL,
  `categoria` varchar(30) NOT NULL,
  PRIMARY KEY (`idproducto`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `productos` */

insert  into `productos`(`idproducto`,`nombreproducto`,`descripcion`,`precio`,`categoria`) values 
(1,'Hamburguesa clásica','Deliciosa hamburguesa con carne jugosa, queso derretido, lechuga fresca, tomate y salsa especial. Acompañada de papas fritas crujientes',9.99,'Comida rápida'),
(2,'Pasta primavera','Fusión perfecta de fettuccine al dente con una variedad de vegetales frescos, como zanahorias, brócoli y champiñones, en una cremosa salsa alfredo',12.99,'Italiana'),
(3,'Sushi variado','Una selección exquisita de sushi fresco, incluyendo nigiri de salmón, rollos de California y tempura de camarón. Acompañado de salsa de soja y wasabi',14.99,'Asiática'),
(4,'Ensalada mediterránea','\"Ensalada refrescante con lechuga mixta, tomate cherry, pepino, aceitunas negras, queso feta y aderezo de aceite de oliva y limón. Una explosión de sabores mediterráneos',8.99,'Ensaladas'),
(5,'Taco al pastor','Tortilla de maíz suave rellena de suculenta carne de cerdo marinada con especias tradicionales, cebolla, cilantro y piña. Acompañado de salsa picante',2.99,'Mexicana'),
(6,'Ramen Tonkotsu','Un tazón de fideos ramen sumergidos en un caldo rico y cremoso de cerdo tonkotsu. Se sirve con rebanadas de cerdo chashu, huevo marinado, cebollas verdes y alga nori',13.99,'Japonesa'),
(7,'Pizza Hawaiana','Deliciosa pizza con jamón, piña y queso derretido',12.99,'Comidas rápidas'),
(8,'Ensalada César','Ensalada fresca con lechuga, pollo a la parrilla, croutones y aderezo César',8.99,'Ensaladas'),
(9,'Taco de carne asada','Tortilla de maíz rellena de tierna carne asada, cebolla y cilantro',2.99,'Comidas mexicanas'),
(10,'Pasta Alfredo','Fetuccini en salsa cremosa de queso parmesano y mantequilla',10.99,'Pastas'),
(11,'Sopa de pollo','Caliente y reconfortante sopa de pollo con verduras',6.99,'Sopas'),
(12,'Burrito de pollo','Burrito grande relleno de pollo, arroz, frijoles y salsa',7.99,'Comidas mexicanas'),
(13,'Lasagna de carne','Deliciosa lasaña casera con capas de pasta, carne molida y salsa de tomate',14.99,'Pastas'),
(14,'Pollo al curry','Pollo tierno en una sabrosa salsa de curry con arroz',13.99,'Platos principales');

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `idempleado` int(11) NOT NULL,
  `nombreusuario` varchar(30) NOT NULL,
  `claveacceso` varchar(100) NOT NULL,
  `nivelacceso` char(20) NOT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `uk_usuario_tusuarios` (`nombreusuario`,`claveacceso`),
  KEY `fk_idempleado_tusuarios` (`idempleado`),
  CONSTRAINT `fk_idempleado_tusuarios` FOREIGN KEY (`idempleado`) REFERENCES `empleados` (`idempleado`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `usuarios` */

insert  into `usuarios`(`idusuario`,`idempleado`,`nombreusuario`,`claveacceso`,`nivelacceso`) values 
(1,1,'monoloco','$2y$10$eb15pmRguuB3rfT6qxeAWunSPjgtOE2ldKlAiLozdbazAu5so6DYW','ADMIN'),
(2,2,'perroloco','$2y$10$eb15pmRguuB3rfT6qxeAWunSPjgtOE2ldKlAiLozdbazAu5so6DYW','EMPLEADO'),
(3,3,'gatoloco','$2y$10$eb15pmRguuB3rfT6qxeAWunSPjgtOE2ldKlAiLozdbazAu5so6DYW','EMPLEADO'),
(4,4,'patoloco','$2y$10$eb15pmRguuB3rfT6qxeAWunSPjgtOE2ldKlAiLozdbazAu5so6DYW','EMPLEADO');

/* Procedure structure for procedure `spu_canbiarestado` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_canbiarestado` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_canbiarestado`(
in _idmesa INT ,
in _estado CHAR(1))
begin 
UPDATE mesas SET
estado = _estado
	where idmesa =_idmesa;
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_detalle_orden` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_detalle_orden` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_detalle_orden`(
IN _idorden int,
IN _idmesa int)
BEGIN
select detalle_ordenes.`iddetalle_orden`,
	productos.nombreproducto,
	detalle_ordenes.`cantidad`,
	detalle_ordenes.precio,
	detalle_ordenes.`cantidad` * detalle_ordenes.precio 'Importe'
	 from detalle_ordenes
left join ordenes on ordenes.idorden = detalle_ordenes.idorden
left join productos on productos.idproducto = detalle_ordenes.idproducto
where detalle_ordenes.`idorden` = _idorden and ordenes.`idmesa` = _idmesa;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_detalle_orden_registrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_detalle_orden_registrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_detalle_orden_registrar`(
in _idmesa int,
in _idproducto int,
in _cantidad int,
in _precio decimal(7,2)
)
begin
	 declare producto_existe int;
	 
	 declare _idorden int;
	 
	 select idorden into _idorden
	 from ordenes where idmesa = _idmesa and fechahorapago  IS NULL;
	 
	 select count(*) into producto_existe
	 from detalle_ordenes where idorden = _idorden and idproducto = _idproducto;
	 
	 if producto_existe >0 then 
		update detalle_ordenes set
		cantidad = cantidad + _cantidad
		where idorden = _idorden and idproducto = _idproducto;
	 else
		insert into detalle_ordenes(idorden,idproducto, cantidad, precio) values
		(_idorden, _idproducto, _cantidad, _precio);		
	 end if;
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_grafico` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_grafico` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_grafico`()
begin 
select productos.`categoria`, sum(detalle_ordenes.cantidad) as 'cantidad'
from ordenes
left join detalle_ordenes  on detalle_ordenes.`idorden` = ordenes.`idorden`
LEFT join productos on productos.`idproducto` = productos.idproducto
group by productos.`categoria`;
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_graficose` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_graficose` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_graficose`()
begin 
select CONCAT (emp.nombre, ' ', emp.apellido) AS 'Empleado',
	count(*) as 'Ventas'
	from ordenes 
  LEFT JOIN empleados ON empleados.idempleado = ordenes.idempleado
  LEFT JOIN personas emp ON emp.idpersona = empleados.idpersona 
  group by Empleado;
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_listar_empleados` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_listar_empleados` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_empleados`()
begin
select empleados.idempleado,personas.apellido, personas.nombre,
	empleados.nombrerol
from empleados
inner join personas on personas.`idpersona` = empleados.idpersona;
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_listar_mesas` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_listar_mesas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_mesas`()
BEGIN
SELECT* FROM mesas;    
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_listar_ordenes` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_listar_ordenes` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_ordenes`()
BEGIN
SELECT
	ordenes.idorden,
	mesas.numesa,
	mesas.capacidad,
	CONCAT (cli.nombre, ' ', cli.apellido) AS 'Cliente',
	ordenes.fechahoraorden,	
	ordenes.estado
FROM ordenes
  LEFT JOIN mesas ON mesas.idmesa = ordenes.idmesa
  LEFT JOIN empleados ON empleados.idempleado = ordenes.idempleado
  LEFT JOIN personas emp ON emp.idpersona = empleados.idpersona
  LEFT JOIN personas cli ON cli.idpersona = ordenes.idcliente
	WHERE ordenes.idorden 
	IN(SELECT MAX(ordenes.idorden) FROM ordenes GROUP BY ordenes.`idorden`) 
	ORDER BY ordenes.`idorden` ASC;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_listar_productos` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_listar_productos` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_productos`()
begin
select idproducto,nombreproducto, precio 
	from productos
	order by nombreproducto;
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_ordenes_buscar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_ordenes_buscar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_ordenes_buscar`( IN _idorden INT)
BEGIN
SELECT ordenes.idorden,
	mesas.numesa, 
	CONCAT (cli.nombre, ' ', cli.apellido) AS 'Cliente',
	CONCAT (emp.nombre, ' ', emp.apellido) AS 'Empleado',
	ordenes.fechahoraorden,
	ordenes.tipocomprobante,
	ordenes.numcomprobante,
	ordenes.estado
	FROM ordenes
  LEFT JOIN mesas ON mesas.idmesa = ordenes.idmesa
  LEFT JOIN empleados ON empleados.idempleado = ordenes.idempleado
  LEFT JOIN personas emp ON emp.idpersona = empleados.idpersona
  LEFT JOIN personas cli ON cli.idpersona = ordenes.idcliente
  WHERE ordenes.idorden = _idorden;
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_producto_actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_producto_actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_producto_actualizar`(
    IN _idproducto INT,
    IN _nombreproducto VARCHAR(80),
    IN _descripcion VARCHAR(500),
    IN _precio DECIMAL(7,2),
    IN _categoria VARCHAR(30)
)
BEGIN
    UPDATE productos
    SET nombreproducto = _nombreproducto,
        descripcion = _descripcion,
        precio = _precio,
        categoria = _categoria
    WHERE idproducto = _idproducto;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_producto_eliminar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_producto_eliminar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_producto_eliminar`(
    IN _idproducto INT
)
BEGIN
    DELETE FROM productos WHERE idproducto = _idproducto;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_producto_listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_producto_listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_producto_listar`()
BEGIN
    SELECT * FROM productos;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_producto_obt` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_producto_obt` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_producto_obt`(
    IN _idproducto INT
)
BEGIN
    select * FROM productos WHERE idproducto = _idproducto;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_producto_registrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_producto_registrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_producto_registrar`(
    IN _nombreproducto VARCHAR(80),
    IN _descripcion VARCHAR(500),
    IN _precio DECIMAL(7,2),
    IN _categoria VARCHAR(30)
)
BEGIN
    INSERT INTO productos (nombreproducto, descripcion, precio, categoria)
    VALUES (_nombreproducto, _descripcion, _precio, _categoria);
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_registar_detalle_orden` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_registar_detalle_orden` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_registar_detalle_orden`(
in _idproducto int,
in _cantidad int,
IN _precio   decimal(7,2)
)
begin
set @ultima_orden_id = (select max(idorden)  as 'id'from ordenes);
insert into detalle_ordenes (idorden,idproducto,cantidad, precio) values
(@ultima_orden_id, _idproducto, _cantidad, _precio);
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_registrar_orden` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_registrar_orden` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_registrar_orden`(
IN _idmesa		TINYINT, 
IN _idempleado		INT)
BEGIN
INSERT INTO ordenes (idmesa, idempleado) VALUES
(_idmesa,_idempleado);

update mesas set
estado = 'O'
where idmesa = _idmesa;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_user_login` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_user_login` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_user_login`(IN _nombreusuario VARCHAR(30))
BEGIN 
SELECT 
	usuarios.`idusuario`, personas.`nombre`, personas.`apellido`,
	usuarios.`nombreusuario`, usuarios.`claveacceso`, empleados.`nombrerol`,personas.`correo`
FROM usuarios
INNER JOIN empleados ON empleados.`idempleado` = `usuarios`.`idempleado`
INNER JOIN personas ON personas.`idpersona` = empleados.`idpersona`
WHERE nombreusuario = _nombreusuario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_ventaxmesa` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_ventaxmesa` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_ventaxmesa`( in _idmesa int)
begin
select ordenes.`idorden`from ordenes
left join mesas on mesas.idmesa = ordenes.`idmesa`
where ordenes.`estado` ='PE' and mesas.idmesa = _idmesa;
end */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
