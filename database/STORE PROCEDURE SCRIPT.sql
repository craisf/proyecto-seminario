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
FROM ordenes
  RIGHT JOIN detalle_ordenes ON detalle_ordenes.`idorden` = ordenes.`idorden`
  INNER JOIN productos ON productos.idproducto = detalle_ordenes.idproducto
  LEFT JOIN mesas ON mesas.idmesa = ordenes.idmesa
  LEFT JOIN empleados ON empleados.idempleado = ordenes.idempleado
  LEFT JOIN personas emp ON emp.idpersona = empleados.idpersona
	WHERE ordenes.idorden 
	IN(SELECT MAX(ordenes.idorden) FROM ordenes GROUP BY ordenes.`idorden`) 
	ORDER BY ordenes.`idorden` ASC;
END $$

CALL spu_listar_ordenes()
-- -----------------------------------------------------------------------------

SELECT * FROM ordenes

INSERT INTO ordenes (idmesa) VALUES ('3')
SELECT * FROM detalle_ordenes
SELECT * FROM pagos

INSERT INTO detalle_ordenes(idorden, idcliente, idproducto, cantidad,idpago) VALUES('3','4','5','3','1')

DELIMITER $$
CREATE PROCEDURE listar_empleados()
BEGIN
SELECT personas.`nombre`, personas.`apellido`FROM empleados
INNER JOIN personas ON personas.idpersona = empleados.`idpersona`;
END $$

 
DELIMITER $$
CREATE PROCEDURE spu_ordenes_registrar(IN _idmesa INT, IN _idempleado INT, IN _idcliente INT, IN _idestadoorden INT)
BEGIN
INSERT INTO ordenes (idmesa, idempleado, idcliente, idestadoorden)
VALUES (_idmesa ,_idempleado,_idcliente ,_idestadoorden)
END $$

DROP PROCEDURE spu_registrar

DELIMITER $$
CREATE PROCEDURE spu_registrar(
IN _idmesa INT,
IN _idempleado INT,
IN _idorden INT,
IN _idcliente INT,
IN _idproducto INT,
IN _cantidad DECIMAL(7,2),
IN _idpago 

)
BEGIN
INSERT INTO ordenes (idmesa, idempleado, idestadoorden)
VALUES (_idmesa ,_idempleado,_idestadoorden);
END $$

CALL spu_registrar('2','3','1');


DELIMITER  $$
CREATE PROCEDURE spu_editar_orden(
IN _idorden INT,
IN _idmesa INT,
IN _idempleado INT,
IN _idcliente INT,
IN _idestadoorden INT)
BEGIN 
UPDATE ordenes SET
idmesa = _idmesa,
idempleado = _idempleado,
idcliente = _idcliente,
idestadoorden = _idestadooren
WHERE idorden = _idorden;
END $$


















