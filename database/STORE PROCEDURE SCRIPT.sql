DELIMITER $$
CREATE PROCEDURE spu_user_login(IN _nombreusuario VARCHAR(30))
BEGIN 
SELECT usuarios.`idusuario`, personas.`nombre`, personas.`apellido`,
usuarios.`nombreusuario`, usuarios.`claveacceso`, empleados.`nombrerol` FROM usuarios
INNER JOIN empleados ON empleados.`idempleado` = `usuarios`.`idempleado`
INNER JOIN personas ON personas.`idpersona` = empleados.`idpersona`
END $$