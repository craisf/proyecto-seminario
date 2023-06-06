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

-- ----------------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_ventaxmesa( IN _idmesa INT)
BEGIN
SELECT ordenes.`idorden`FROM ordenes
LEFT JOIN mesas ON mesas.idmesa = ordenes.`idmesa`
WHERE ordenes.`estado` ='PE' AND mesas.idmesa = _idmesa;
END $$

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


-- -----------------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_listar_empleados()
BEGIN
SELECT empleados.idempleado,personas.apellido, personas.nombre,
	empleados.nombrerol
FROM empleados
INNER JOIN personas ON personas.`idpersona` = empleados.idpersona;
END $$


-- -----------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_listar_productos()
BEGIN
SELECT idproducto,nombreproducto, precio 
	FROM productos
	ORDER BY nombreproducto;
END $$

-- ---------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- GRAFICOS

DELIMITER $$
CREATE PROCEDURE spu_grafico()
BEGIN 
SELECT productos.`categoria`, SUM(detalle_ordenes.cantidad) AS 'cantidad'
FROM ordenes
LEFT JOIN detalle_ordenes  ON detalle_ordenes.`idorden` = ordenes.`idorden`
LEFT JOIN productos ON productos.`idproducto` = productos.idproducto
GROUP BY productos.`categoria`;
END $$


DELIMITER $$
CREATE PROCEDURE spu_graficose()
BEGIN 
SELECT CONCAT (emp.nombre, ' ', emp.apellido) AS 'Empleado',
	COUNT(*) AS 'Ventas'
	FROM ordenes 
  LEFT JOIN empleados ON empleados.idempleado = ordenes.idempleado
  LEFT JOIN personas emp ON emp.idpersona = empleados.idpersona 
  GROUP BY Empleado;
END $$




SELECT * FROM ordenes
SELECT* FROM detalle_ordenes
SELECT * FROM productos



-- -----------------------------------------------------------------
-- CRUD PRODUCTOS


DELIMITER $$
CREATE PROCEDURE spu_producto_listar()
BEGIN
    SELECT * FROM productos;
END $$
DELIMITER ;




DELIMITER $$
CREATE PROCEDURE spu_producto_registrar(
    IN _nombreproducto VARCHAR(80),
    IN _descripcion VARCHAR(500),
    IN _precio DECIMAL(7,2),
    IN _categoria VARCHAR(30)
)
BEGIN
    INSERT INTO productos (nombreproducto, descripcion, precio, categoria)
    VALUES (_nombreproducto, _descripcion, _precio, _categoria);
END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE spu_producto_eliminar(
    IN _idproducto INT
)
BEGIN
    DELETE FROM productos WHERE idproducto = _idproducto;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE spu_producto_obt(
    IN _idproducto INT
)
BEGIN
    SELECT * FROM productos WHERE idproducto = _idproducto;
END $$
DELIMITER ;




DELIMITER $$
CREATE PROCEDURE spu_producto_actualizar(
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
END $$
DELIMITER ;
