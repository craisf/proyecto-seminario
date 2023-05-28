-- ----------------------------------------------------------
INSERT INTO personas (nombre, apellido, celular, correo, direccion, tipodoc, numerodoc)VALUES
('Carlos ','Moran Gonzales','956321478','carlos@gmail.com','Santa Rosa','DNI','71594314'),
('María','López Arriaga','912345678','maria.lopez@gmail.com','Calle 123, Ciudad Ejemplo','DNI','12345678'),
('Juan','García Muñoz','998765432','juan.garcia@gmail.com',' Avenida Principal, Pueblo Nuevo','DNI','75369821'),
('Ana','Rodríguez Salazar','955556231','ana.rodriguez@gmail.com','Calle 456, Urbanización Bella Vista','DNI','98765432'),
('Pedro','Martínez Suñiga','911561283','pedro.martinez@gmail.com','Avenida Libertad, Barrio Centro','DNI','87654321'),
('Laura','Sánchez Gutierrez','999005208','laura.sanchez@gmail.com','Calle 789, Colonia Esperanza','DNI','98765405')

SELECT * FROM personas

-- ----------------------------------------------------------
INSERT INTO empleados (idpersona, nombrerol, turnoinicio) VALUES 
('1','RECEPCIONISTA','08:00:00'),
('2','MAITRE','08:00:00'),
('3','MESERO','08:00:00'),
('4','CHEF','08:00:00')


SELECT * FROM empleados

-- -------------------------------------------------------------
INSERT INTO usuarios (idempleado, nombreusuario, claveacceso, nivelacceso) VALUES
('1','monoloco','123456','ADMIN'),
('2','perroloco','123456','EMPLEADO'),
('3','gatoloco','123456','EMPLEADO'),
('4','patoloco','123456','EMPLEADO')


SELECT *  FROM usuarios

UPDATE
usuarios
SET
  claveacceso = '$2y$10$eb15pmRguuB3rfT6qxeAWunSPjgtOE2ldKlAiLozdbazAu5so6DYW'
WHERE idusuario = '1' 
-- ------------------------
INSERT INTO mesas (numesa, capacidad) VALUES
(1, 4),
(2, 8),
(3, 6),
(4, 12)

SELECT * FROM mesas
 -- ---------------------------
INSERT INTO productos (nombreproducto,descripcion,precio,categoria) VALUES
        (
          'Hamburguesa clásica',
          'Deliciosa hamburguesa con carne jugosa, queso derretido, lechuga fresca, tomate y salsa especial. Acompañada de papas fritas crujientes',
          '9.99',
          'Comida rápida'
        ),
        (
          'Pasta primavera',
          'Fusión perfecta de fettuccine al dente con una variedad de vegetales frescos, como zanahorias, brócoli y champiñones, en una cremosa salsa alfredo',
          '12.99',
          'Italiana'
        ),
        (
          'Sushi variado',
          'Una selección exquisita de sushi fresco, incluyendo nigiri de salmón, rollos de California y tempura de camarón. Acompañado de salsa de soja y wasabi',
          '14.99',
          'Asiática'
        ),
        (
          'Ensalada mediterránea',
          '"Ensalada refrescante con lechuga mixta, tomate cherry, pepino, aceitunas negras, queso feta y aderezo de aceite de oliva y limón. Una explosión de sabores mediterráneos',
          '8.99',
          'Ensaladas'
        ),
        (
          'Taco al pastor',
          'Tortilla de maíz suave rellena de suculenta carne de cerdo marinada con especias tradicionales, cebolla, cilantro y piña. Acompañado de salsa picante',
          '2.99',
          'Mexicana'
        ),
        (
          'Ramen Tonkotsu',
          'Un tazón de fideos ramen sumergidos en un caldo rico y cremoso de cerdo tonkotsu. Se sirve con rebanadas de cerdo chashu, huevo marinado, cebollas verdes y alga nori',
          '13.99',
          'Japonesa'
        )
        SELECT * FROM productos 
-- ---------------------------------
 INSERT INTO ordenes (idmesa,idempleado,idcliente,estado)VALUES
('1', '3', '5', 'PENDIENTE'),
('2', '3', '6', 'PENDIENTE')
SELECT * FROM ordenes
 -- ---------------------------------
INSERT INTO detalle_ordenes (idorden, idproducto, cantidad)
VALUES
('1', '2', '4'),
('2', '3', '8')
SELECT * FROM detalle_ordenes
-- --------------------------
INSERT INTO pagos (iddetalle_orden,fechahorapago,totalpagar)VALUES
('1','2023-05-26','51.96'),
('2','2023-05-26','119.92')

SELECT * FROM pagos