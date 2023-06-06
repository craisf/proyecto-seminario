-- ----------------------------------------------------------
INSERT INTO personas (nombre, apellido, celular, correo, direccion, dni)VALUES
('Carlos ','Moran ','956321478','carlos@gmail.com','Santa Rosa','71594314'),
('María','López ','912345678','maria.lopez@gmail.com','Calle 123, Ciudad Ejemplo','12345678'),
('Juan','García ','998765432','juan.garcia@gmail.com',' Avenida Principal, Pueblo Nuevo','75369821'),
('Ana','Rodríguez ','955556231','ana.rodriguez@gmail.com','Calle 456, Urbanización Bella Vista','98765432'),
('Pedro','Martínez ','911561283','pedro.martinez@gmail.com','Avenida Libertad, Barrio Centro','87654321'),
('Laura','Sánchez ','999005208','laura.sanchez@gmail.com','Calle 789, Colonia Esperanza','98765405')

SELECT * FROM personas

-- ----------------------------------------------------------
INSERT INTO empleados (idpersona, nombrerol) VALUES 
('1','RECEPCIONISTA'),
('2','MESERO'),
('3','MESERO'),
('4','MESERO')


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
        ),       
	('Pizza Hawaiana', 'Deliciosa pizza con jamón, piña y queso derretido', 12.99, 'Comidas rápidas'),
	('Ensalada César', 'Ensalada fresca con lechuga, pollo a la parrilla, croutones y aderezo César', 8.99, 'Ensaladas'),
	('Taco de carne asada', 'Tortilla de maíz rellena de tierna carne asada, cebolla y cilantro', 2.99, 'Comidas mexicanas'),
	('Pasta Alfredo', 'Fetuccini en salsa cremosa de queso parmesano y mantequilla', 10.99, 'Pastas'),
	('Sopa de pollo', 'Caliente y reconfortante sopa de pollo con verduras', 6.99, 'Sopas'),
	('Burrito de pollo', 'Burrito grande relleno de pollo, arroz, frijoles y salsa', 7.99, 'Comidas mexicanas'),
	('Lasagna de carne', 'Deliciosa lasaña casera con capas de pasta, carne molida y salsa de tomate', 14.99, 'Pastas'),
	('Pollo al curry', 'Pollo tierno en una sabrosa salsa de curry con arroz', 13.99, 'Platos principales')
	
        SELECT * FROM productos 
-- --------------------------------------
 INSERT INTO ordenes (idmesa,idempleado, idcliente,tipocomprobante,numcomprobante )VALUES
('1','1','5','BS','BLS-00001'),
('2',NULL,'5','','',)

SELECT * FROM ordenes
 -- ---------------------------------
INSERT INTO detalle_ordenes (idorden,idproducto, cantidad)
VALUES
('1', '1','','2'),
('2', '2','','1')

SELECT * FROM detalle_ordenes





