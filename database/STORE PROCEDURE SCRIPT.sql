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
  mesas.numesa, CONCAT (emp.nombre, ' ',
  emp.apellido) AS 'Empleado',
  ordenes.fechahoraorden,
  estado_ordenes.estado
FROM
  ordenes
  INNER JOIN detalle_ordenes ON detalle_ordenes.`idorden` = ordenes.`idorden`
  INNER JOIN productos ON productos.idproducto = detalle_ordenes.idproducto
  INNER JOIN estado_ordenes ON estado_ordenes.idestadoorden = ordenes.idestadoorden
  INNER JOIN mesas ON mesas.idmesa = ordenes.idmesa
  INNER JOIN empleados ON empleados.idempleado = ordenes.idempleado
  INNER JOIN personas emp ON emp.idpersona = empleados.idpersona

	WHERE estado_ordenes.estado IN(SELECT MAX(estado_ordenes.estado) FROM estado_ordenes GROUP BY estado) 
	ORDER BY estado_ordenes.estado ASC;
END $$

CALL spu_listar_ordenes()

SELECT idempleado, CONCAT (personas.nombre,personas.apellido) AS 'empleados',nombrerol FROM empleados
    INNER JOIN personas ON personas.idpersona = empleados.idpersona
    
UPDATE ordenes SET
estado = 'EN proceso'
WHERE idorden = 1


 INSERT INTO ordenes (idmesa,idempleado,idcliente,idestadoorden)VALUES
('1', '3', '5', 'PENDIENTE'),
('2', '3', '6', 'PENDIENTE')
SELECT * FROM ordenes


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
IN _idestadoorden INT
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


















