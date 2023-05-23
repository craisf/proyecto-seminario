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