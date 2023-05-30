-- ------ procedimiento almacenado para iniciar sesion
DELIMITER $$
CREATE PROCEDURE spu_user_login(IN _nombreusuario VARCHAR(30))
BEGIN 
SELECT 
	usuarios.`idusuario`, personas.`nombre`, personas.`apellido`,
	usuarios.`nombreusuario`, usuarios.`claveacceso`, empleados.`nombrerol`,personas.`correo`
FROM usuarios
INNER JOIN empleados ON empleados.`idempleado` = `usuarios`.`idempleado`
INNER JOIN personas ON personas.`idpersona` = empleados.`idpersona`
WHERE nombreusuario = _nombreusuario;
END $$

CALL spu_user_login('monoloco');
-- ----------------------------------------------------

DELIMITER $$
CREATE PROCEDURE spu_listar_ordenes()
BEGIN
SELECT
	ordenes.idorden,
	mesas.numesa,
	mesas.capacidad,
	productos.nombreproducto,
   CONCAT (emp.nombre, ' ', emp.apellido) AS 'Empleado',
  ordenes.fechahoraorden
FROM mesas
  LEFT JOIN detalle_ordenes ON detalle_ordenes.`idorden` = ordenes.`idorden`
  LEFT JOIN productos ON productos.idproducto = detalle_ordenes.idproducto
  LEFT JOIN mesas ON mesas.idmesa = ordenes.idmesa
  LEFT JOIN empleados ON empleados.idempleado = ordenes.idempleado
  LEFT JOIN personas emp ON emp.idpersona = empleados.idpersona
	WHERE ordenes.idorden 
	IN(SELECT MAX(ordenes.idorden) FROM ordenes GROUP BY ordenes.`idorden`) 
	ORDER BY ordenes.`idorden` ASC;
END $$

-- ------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_listar_mesas()
BEGIN
SELECT mesas.numesa,
	mesas.estado,
	mesas.capacidad
   FROM mesas 
   WHERE estado = 'DISPONIBLE';   
END $$

CALL spu_listar_mesas();

-- -----------------------------------------------------------------------------

DELIMITER $$
CREATE PROCEDURE spu_insertar_ordenes()
BEGIN 
INSERT INTO ordenes (idmesa,idempleado,estado,)

END $$

SELECT * FROM ordenes

SELECT * FROM detalle_ordenes

INSERT INTO ordenes (idmesa) VALUES ('3')
SELECT * FROM detalle_ordenes
SELECT * FROM pagos
SELECT * FROM productos
SELECT * FROM mesas
INSERT INTO detalle_ordenes(idorden, idcliente, idproducto, cantidad,idpago) VALUES('3','4','5','3','1')

DELIMITER $$
CREATE PROCEDURE listar_empleados()
BEGIN
SELECT personas.`nombre`, personas.`apellido`FROM empleados
INNER JOIN personas ON personas.idpersona = empleados.`idpersona`;
END $$




DROP PROCEDURE spu_registrar










