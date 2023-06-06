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
END $$

CALL spu_listar_ordenes()
-- ------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_ordenes_buscar( IN _idorden INT)
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
	
END $$

CALL spu_ordenes_buscar(1)
SELECT* FROM ordenes
-- ----------------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_ventaxmesa( IN _idmesa INT)
BEGIN
SELECT ordenes.`idorden`FROM ordenes
LEFT JOIN mesas ON mesas.idmesa = ordenes.`idmesa`
WHERE ordenes.`estado` ='PE' AND mesas.idmesa = _idmesa;
END $$

CALL spu_ventaxmesa('1');
-- --------------------------------------------------- 
DELIMITER $$
CREATE PROCEDURE spu_registrar_orden(
IN _idmesa		TINYINT, 
IN _idempleado		INT)
BEGIN
INSERT INTO ordenes (idmesa, idempleado) VALUES
(_idmesa,_idempleado);

UPDATE mesas SET
estado = 'O'
WHERE idmesa = _idmesa;
END $$

SELECT * FROM ordenes
SELECT * FROM detalle_ordenes
-- ----------------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_registar_detalle_orden(
IN _idproducto INT,
IN _cantidad INT,
IN _precio   DECIMAL(7,2)
)
BEGIN
SET @ultima_orden_id = (SELECT MAX(idorden)  AS 'id'FROM ordenes);
INSERT INTO detalle_ordenes (idorden,idproducto,cantidad, precio) VALUES
(@ultima_orden_id, _idproducto, _cantidad, _precio);
END $$


-- ----------------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_detalle_orden
(
IN _idorden INT,
IN _idmesa INT)
BEGIN
SELECT detalle_ordenes.`iddetalle_orden`,
	productos.nombreproducto,
	detalle_ordenes.`cantidad`,
	detalle_ordenes.precio,
	detalle_ordenes.`cantidad` * detalle_ordenes.precio 'Importe'
	 FROM detalle_ordenes
LEFT JOIN ordenes ON ordenes.idorden = detalle_ordenes.idorden
LEFT JOIN productos ON productos.idproducto = detalle_ordenes.idproducto
WHERE detalle_ordenes.`idorden` = _idorden AND ordenes.`idmesa` = _idmesa;
END $$

CALL spu_detalle_orden ('1','1');
-- -----------------------------------
DELIMITER $$
CREATE PROCEDURE spu_detalle_orden_registrar(
IN _idmesa INT,
IN _idproducto INT,
IN _cantidad INT,
IN _precio DECIMAL(7,2)
)
BEGIN
	 DECLARE producto_existe INT;
	 
	 DECLARE _idorden INT;
	 
	 SELECT idorden INTO _idorden
	 FROM ordenes WHERE idmesa = _idmesa AND fechahorapago  IS NULL;
	 
	 SELECT COUNT(*) INTO producto_existe
	 FROM detalle_ordenes WHERE idorden = _idorden AND idproducto = _idproducto;
	 
	 IF producto_existe >0 THEN 
		UPDATE detalle_ordenes SET
		cantidad = cantidad + _cantidad
		WHERE idorden = _idorden AND idproducto = _idproducto;
	 ELSE
		INSERT INTO detalle_ordenes(idorden,idproducto, cantidad, precio) VALUES
		(_idorden, _idproducto, _cantidad, _precio);		
	 END IF;
END $$


-- ---------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_listar_mesas()
BEGIN
SELECT* FROM mesas;    
END $$

CALL spu_listar_mesas();


DELIMITER $$
CREATE PROCEDURE spu_canbiarestado(
IN _idmesa INT ,
IN _estado CHAR(1))
BEGIN 
UPDATE mesas SET
estado = _estado
	WHERE idmesa =_idmesa;
END $$

SELECT * FROM mesas
CALL spu_canbiarestado('1','O');
-- -----------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_listar_empleados()
BEGIN
SELECT empleados.idempleado,personas.apellido, personas.nombre,
	empleados.nombrerol
FROM empleados
INNER JOIN personas ON personas.`idpersona` = empleados.idpersona;
END $$

CALL spu_listar_empleados();
-- -----------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_listar_productos()
BEGIN
SELECT idproducto,nombreproducto, precio 
	FROM productos
	ORDER BY nombreproducto;
END $$

CALL spu_listar_productos();
-- ---------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_insertar_ordenes()
BEGIN 
INSERT INTO ordenes (idmesa,idempleado,estado,)

END $$



-- que me registre en la tabla ordenes dependiendo de la mesa Y que a su ves en la tabla mesas cambie el estado  a 'OCUPADO', Y me registre esa orden en la tabla detalle_ordenes  

DELIMITER //


CREATE PROCEDURE RegistrarOrden(
  IN mesa_id INT,  
  IN productos_ids VARCHAR(255),
  IN cantidades VARCHAR(255)
)
BEGIN
  DECLARE orden_id INT;

  -- Insertar registro de la orden
  INSERT INTO ordenes (idmesa, estado)
  VALUES (mesa_id, 'PEN');

  -- Obtener el ID de la orden recién insertada
  SET orden_id = LAST_INSERT_ID();

  -- Actualizar el estado de la mesa a 'OCUPADO'
  UPDATE mesas SET estado = 'OCUPADO' WHERE idmesa = mesa_id;

  -- Separar los IDs de los productos y las cantidades
  SET @productos_ids = productos_ids;
  SET @cantidades = cantidades;

  WHILE CHAR_LENGTH(@productos_ids) > 0 DO
    SET @pos = LOCATE(',', @productos_ids);
    SET @producto_id = IF(@pos > 0, SUBSTRING(@productos_ids, 1, @pos - 1), @productos_ids);
    SET @productos_ids = IF(@pos > 0, SUBSTRING(@productos_ids, @pos + 1), '');

    SET @pos = LOCATE(',', @cantidades);
    SET @cantidad = IF(@pos > 0, SUBSTRING(@cantidades, 1, @pos - 1), @cantidades);
    SET @cantidades = IF(@pos > 0, SUBSTRING(@cantidades, @pos + 1), '');

    -- Insertar detalles de la orden
    INSERT INTO detalle_ordenes (idorden, idproducto, cantidad)
    VALUES (orden_id, @producto_id, @cantidad);
  END WHILE;
END //

DELIMITER ;


CALL RegistrarOrden('2', '4,5,1', '2,1,3');

SELECT * FROM ordenes
-- -------------------------------------------------------------------



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










