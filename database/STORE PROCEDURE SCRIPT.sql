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
CREATE PROCEDURE spu_ordenes_estados()
BEGIN
	SELECT 
		CONCAT(personas.`nombre`, ' ', personas.`apellido`) AS 'cliente',
		mascotas.`nombre`,
		tipomascotas.`nombreTipo`,
		razas.`nombreRaza`,
		estados.`nombreEstado`,
		procesoadopciones.`idEstado`,
		adopciones.`idAdopcion`,
		mascotas.`urlimgmasc`,
		mascotas.`altura`,
		mascotas.`color`,
		mascotas.sexo,
		personas.`documentoIdentidad`,
		personas.`telefono`,
		personas.`email`,
		personas.`fechaNacimiento`
	FROM ordenes
	INNER JOIN detalle_ordenes ON detalle_ordenes.`idorden` = ordenes.`idorden`
	INNER JOIN detalle_ordenes ON detalle_ordenes.idproducto = productos.idproducto
	INNER JOIN mesas ON mesas.idmesa = ordenes.idmesa
	INNER JOIN empleados ON empleados.idempleado = ordenes.idempleado
	INNER JOIN empleados ON empleados.idpersona = personas.idpersona
	
	INNER JOIN adoptantes ON adoptantes.`idAdoptante` = adopciones.`idAdoptante`
	INNER JOIN personas ON personas.`idPersona` = adoptantes.`idPersona`
	INNER JOIN mascotas ON mascotas.`idMascota` = adopciones.`idMascota`
	INNER JOIN razas ON razas.idRaza = mascotas.`idRaza`
	INNER JOIN tipomascotas ON `tipomascotas`.`idTipmas` = razas.`idTipmas`
	INNER JOIN estados ON estados.`idEstado` = procesoadopciones.`idEstado`
	WHERE idProcesoAdopcion 
	IN (SELECT MAX(idProcesoAdopcion) FROM procesoadopciones GROUP BY idAdopcion)
    ORDER BY estados.secuencia ASC;
END $$



DELIMITER $$
CREATE PROCEDURE spu_listar_ordenes()
BEGIN
SELECT
ordenes.idorden,
CONCAT (cli.nombre,
  cli.apellido) AS 'Cliente',
  productos.nombreproducto,
  mesas.numesa, CONCAT (emp.nombre, ' ',
  emp.apellido) AS 'Empleado',
  ordenes.fechahoraorden,
  ordenes.estado
FROM
  ordenes
  INNER JOIN detalle_ordenes ON detalle_ordenes.`idorden` = ordenes.`idorden`
  INNER JOIN productos ON productos.idproducto = detalle_ordenes.idproducto
  INNER JOIN mesas ON mesas.idmesa = ordenes.idmesa
  INNER JOIN empleados ON empleados.idempleado = ordenes.idempleado
  INNER JOIN personas emp ON emp.idpersona = empleados.idpersona
  INNER JOIN personas cli ON cli.idpersona = ordenes.idcliente
	WHERE ordenes.estado IN(SELECT MAX(ordenes.estado) FROM ordenes GROUP BY idorden) 
	ORDER BY ordenes.estado ASC
END $$


SELECT idempleado, CONCAT (personas.nombre,personas.apellido) AS 'empleados',nombrerol FROM empleados
    INNER JOIN personas ON personas.idpersona = empleados.idpersona
    
UPDATE ordenes SET
estado = 'EN proceso'
WHERE idorden = 1