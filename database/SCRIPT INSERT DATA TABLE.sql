-- ----------------------------------------------------------
INSERT INTO personas (nombre, apellido, celular, correo, direccion, tipodoc, numerodoc)VALUES
('Carlos ','Moran ','956321478','carlos@gmail.com','Santa Rosa','DNI','71594314'),
('María','López ','912345678','maria.lopez@gmail.com','Calle 123, Ciudad Ejemplo','DNI','12345678'),
('Juan','García ','998765432','juan.garcia@gmail.com',' Avenida Principal, Pueblo Nuevo','DNI','75369821'),
('Ana','Rodríguez ','955556231','ana.rodriguez@gmail.com','Calle 456, Urbanización Bella Vista','DNI','98765432'),
('Pedro','Martínez ','911561283','pedro.martinez@gmail.com','Avenida Libertad, Barrio Centro','DNI','87654321'),
('Laura','Sánchez ','999005208','laura.sanchez@gmail.com','Calle 789, Colonia Esperanza','DNI','98765405')

SELECT * FROM personas

-- ----------------------------------------------------------
INSERT INTO empleados (idpersona, nombrerol) VALUES 
('1','RECEPCIONISTA'),
('2','MAITRE'),
('3','MESERO'),
('4','CHEF')


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
('Mesa 1', 2),
('Mesa 2', 4),
('Mesa 3', 6),
('Mesa 4', 2),
('Mesa 5', 4),
('Mesa 6', 8),
('Mesa 7', 6),
('Mesa 8', 4),
('Mesa 9', 6),
('Mesa 10', 2),
('Mesa 11', 2),
('Mesa 12', 2),
('Mesa 13', 2),
('Mesa 14', 2)

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
INSERT INTO estado_ordenes (estado) VALUES
('Pendiente'),
('Proceso'), 
('entregadado')

SELECT * FROM estado_ordenes

-- --------------------------------------
 INSERT INTO ordenes (idmesa,idempleado )VALUES
('1','3'),
('2','3')

SELECT * FROM ordenes
 -- ---------------------------------
 INSERT INTO pagos (fechahorapago,totalpagar)VALUES
('2023-05-26','51.96'),
('2023-05-26','119.92')

SELECT * FROM detalle_ordenes
-- ------------------------------
INSERT INTO detalle_ordenes (idorden,idcliente, idproducto, cantidad, idpago)
VALUES
('1', '2', '2', '4','1'),
('2', '3', '4','8','2')







SELECT * FROM pagos