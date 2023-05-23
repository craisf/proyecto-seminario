-- ----------------------------------------------------------
INSERT INTO personas (nombre, apellido, celular, correo, direccion, tipodoc, numerodoc)VALUES
('Carlos Mauricio','Moran Gonzales','956321478','carlos@gmail.com','Santa Rosa','','71594314')

SELECT * FROM personas


-- ----------------------------------------------------------
INSERT INTO empleados (idpersona, nombrerol, turnoinicio, turnofin) VALUES 
('1','RECEPCIONISTA','08:00:00','')

SELECT * FROM empleados

-- -------------------------------------------------------------
INSERT INTO usuarios (idempleado, nombreusuario, claveacceso, nivelacceso) VALUES
('1','monoloco','123456','HOST')

ALTER TABLE usuarios  MODIFY COLUMN claveacceso VARCHAR(90) NOT NULL;

SELECT * FROM usuarios

UPDATE usuarios SET
claveacceso =  '$2y$10$eb15pmRguuB3rfT6qxeAWunSPjgtOE2ldKlAiLozdbazAu5so6DYW'
WHERE idusuario = '1'

-- ------------------------