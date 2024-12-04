--
-- Estructura de tabla para la tabla `sedes`
--ascii COLLATE ascii_general_ci

CREATE TABLE IF NOT EXISTS `sedes` (
  `nombre_departamento` varchar(10) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `edificio` varchar(15) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  `presupuesto` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`nombre_departamento`),
  KEY `edificio` (`edificio`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii COLLATE=ascii_general_ci;

--
-- Volcado de datos para la tabla `department`
--

INSERT INTO `sedes` (`nombre_departamento`, `edificio`, `presupuesto`) VALUES
('Ingles', 'Uneatlantico', '90000.00'),

DELIMITER //
CREATE TRIGGER control_departamento BEFORE INSERT ON sedes FOR EACH ROW
BEGIN
DECLARE msg VARCHAR(255);
IF (NEW.nombre_departamento!='Ingles') THEN SET msg = 'La asignatura impartida es ingles';
SIGNAL SQLSTATE '45000' SET message_text = msg;
END IF;
END //

CREATE TABLE IF NOT EXISTS `profesor` (
  `ID` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `asignatura` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salario` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `asignatura` (`asignatura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `profesor`
--

INSERT INTO `profesor` (`ID`, `nombre`, `asignatura`, `salario`) VALUES
('10256', 'Michael', 'Ingles', '47000.00'),
('13851', 'Peter', 'Ingles', '66000.00'),
('16423', 'James', 'Ingles', '38000.00'),
('28934', 'Kevin', 'Ingles', '52000.00'),
('32563', 'Elvis', 'Ingles', '70000.00'),
('39431', 'Parker', 'Ingles', '82000.00'),
('48941', 'John', 'Ingles', '64000.00'),
('56431', 'Marcus', 'Ingles', '53000.00'),
('74321', 'Cole', 'Ingles', '31000.00'),
('78936', 'Harry', 'Ingles', '44000.00'),
('85438', 'Phil', 'Ingles', '54000.00'),
('99346', 'Declan', 'Ingles', '56000.00');

DELIMITER //
CREATE TRIGGER control_profesor BEFORE INSERT ON profesor FOR EACH ROW
BEGIN
DECLARE msg VARCHAR(255);
IF (NEW.asignatura!='Ingles') THEN SET msg = 'La asignatura impartida es Ingles';
SIGNAL SQLSTATE '45000' SET message_text = msg;
END IF;
END //

-- UNION

-- SELECT 
--  nombre_departamento AS nombre,
--  edificio AS detalle,
--  presupuesto AS extra
-- FROM 
--  sedes

-- UNION

-- SELECT 
--  asignatura AS nombre,
--  CONCAT('Salario: ', salario) AS detalle,
--  NULL AS extra
-- FROM 
--  profesor;




-- Interseccion
-- SELECT 
--  nombre_departamento AS nombre
-- FROM 
--  sedes

-- INTERSECT

-- SELECT 
--   asignatura AS nombre
-- FROM 
--   profesor;


-- Diferencia

-- SELECT 
--   nombre_departamento
-- FROM 
--   sedes

-- EXCEPT

-- SELECT 
--   asignatura
-- FROM 
--   profesor;

-- Reunion Natural
-- SELECT *
-- FROM sedes
-- NATURAL JOIN profesor;

-- Informacion ausente por la izquierda

-- SELECT 
--   s.nombre_departamento,
--   s.edificio,
--   s.presupuesto
-- FROM 
--   sedes s
-- LEFT JOIN 
--   profesor p
-- ON 
--   s.nombre_departamento = p.asignatura
-- WHERE 
--   p.asignatura IS NULL;


-- Informacion ausente por la derecha
-- SELECT 
--   p.ID,
--   p.nombre,
--   p.asignatura,
--   p.salario
-- FROM 
--   sedes s
-- RIGHT JOIN 
--   profesor p
-- ON 
--   s.nombre_departamento = p.asignatura
-- WHERE 
--   s.nombre_departamento IS NULL;


-- Producto cartesiano
-- SELECT *
-- FROM sede
-- CROSS JOIN profesor;


--
-- Base de datos: `examen`
--

--
-- Estructura de datos para la tabla `student
--

CREATE TABLE IF NOT EXISTS `empleado` (
  `ID` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sede` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `sede` (`sede`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`ID`, `name`, `sede`) VALUES
('00128', 'Zhang', 'Comp. Sci.'),
('12345', 'Shankar', 'Comp. Sci.'),
('19991', 'Brandt', 'History'),
('23121', 'Chavez', 'Finance'),
('44553', 'Peltier', 'Physics'),
('45678', 'Levy', 'Physics'),
('54321', 'Williams', 'Comp. Sci.'),
('55739', 'Sanchez', 'Music'),
('70557', 'Snow', 'Physics'),
('76543', 'Brown', 'Comp. Sci.'),
('76653', 'Aoi', 'Elec. Eng.'),
('98765', 'Bourikas', 'Elec. Eng.'),
('98988', 'Tanaka', 'Biology');

DELIMITER //

CREATE TRIGGER verificar_sede
BEFORE INSERT ON empleado
FOR EACH ROW
BEGIN
  DECLARE sede_existe INT;

  SELECT COUNT(*) INTO sede_existe
  FROM sede
  WHERE sede_name = NEW.sede;

  IF sede_existe = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Error: la sede introducida no existe.';
  END IF;
END;
//

DELIMETER;

--
--CONSULTAS
--

SELECT * FROM empleado
WHERE sede LIKE 'comp%' AND name LIKE '%ar';

SELECT * FROM empleado
WHERE ID >50000;

SELECT sede, COUNT(*) AS total_empleados
FROM empleado
GROUP BY sede;

CREATE TABLE IF NOT EXISTS `profesor` (
  `ID` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `asignatura` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salario` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `asignatura` (`asignatura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `profesor`
--

INSERT INTO `profesor` (`ID`, `nombre`, `asignatura`, `salario`) VALUES
('10256', 'Michael', 'Ingles', '47000.00'),
('13851', 'Peter', 'Ingles', '66000.00'),
('16423', 'James', 'Ingles', '38000.00'),
('28934', 'Kevin', 'Ingles', '52000.00'),
('32563', 'Elvis', 'Ingles', '70000.00'),
('39431', 'Parker', 'Ingles', '82000.00'),
('48941', 'John', 'Ingles', '64000.00'),
('56431', 'Marcus', 'Ingles', '53000.00'),
('74321', 'Cole', 'Ingles', '31000.00'),
('78936', 'Harry', 'Ingles', '44000.00'),
('85438', 'Phil', 'Ingles', '54000.00'),
('99346', 'Declan', 'Ingles', '56000.00');

DELIMITER //
CREATE TRIGGER control_profesor BEFORE INSERT ON profesor FOR EACH ROW
BEGIN
DECLARE msg VARCHAR(255);
IF (NEW.asignatura!='Ingles') THEN SET msg = 'La asignatura impartida es Ingles';
SIGNAL SQLSTATE '45000' SET message_text = msg;
END IF;
END //

-- CONSULTAS:
-- Union: 
-- SELECT ID, nombre, asignatura, salario
-- FROM profesor
-- WHERE salario > 50000
-- UNION
-- SELECT ID, nombre, asignatura, salario
-- FROM profesor
-- WHERE nombre LIKE 'P%';

-- Interseccion:
-- SELECT p1.ID, p1.nombre, p1.asignatura, p1.salario
-- FROM profesor p1
-- WHERE salario > 50000
-- AND p1.ID IN (
--     SELECT ID
--     FROM profesor
--     WHERE nombre LIKE 'P%'
-- );

-- Diferencia:
-- SELECT ID, nombre, asignatura, salario
-- FROM profesor
-- WHERE salario <= 50000
--   AND ID NOT IN (
--     SELECT ID
--     FROM profesor
--     WHERE nombre LIKE 'P%'
--   );

-- Agregacion:
-- SELECT SUM(salario) AS total_salario
-- FROM profesor;

-- Reunion Natural:
-- SELECT ID, nombre, asignatura, salario
-- FROM profesor;

-- Producto cartesiano:
-- SELECT *
-- FROM sede
-- CROSS JOIN profesor;

-- ausente por la derecha
-- SELECT 
--   p.ID,
--   p.nombre,
--   p.asignatura,
--   p.salario
-- FROM 
--   sedes s
-- RIGHT JOIN 
--   profesor p
-- ON 
--   s.nombre_departamento = p.asignatura
-- WHERE 
--   s.nombre_departamento IS NULL;

-- Informacion ausente por la izquierda

-- SELECT 
--   s.nombre_departamento,
--   s.edificio,
--   s.presupuesto
-- FROM 
--   sedes s
-- LEFT JOIN 
--   profesor p
-- ON 
--   s.nombre_departamento = p.asignatura
-- WHERE 
--   p.asignatura IS NULL;


CREATE TABLE IF NOT EXISTS `formaciones` (
  `id` decimal(2,0) NOT NULL,
  `nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `definicion` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `empresario` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `definicion` (`definicion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `formaciones` (`id`, `nombre`, `definicion`, `empresario`) VALUES
(1, 'Ingles', 'ING_001', 'Fernando'),
(2, 'Matematicas', 'MAT_002', 'Mateo'),
(3, 'Biologia', 'BIO_003', 'Alicia')
(4, 'Fisica', 'FIS_004', 'Laura'),
(5, 'Quimica', 'QUI_005', 'Pedro'),
(6, 'Historia', 'HIS_006', 'Marta'),
(7, 'Geografia', 'GEO_007', 'Javier'),
(8, 'Programacion', 'PRO_008', 'Sofia'),
(9, 'Arte', 'ART_009', 'Claudia'),
(10, 'Filosofia', 'FIL_010', 'Andres');


--Trigger que actualiza automáticamente el valor de la columna definicion en la misma tabla cuando se inserte o actualice un registro, asegurándose de que siempre sea en mayúsculas.

DELIMITER $$

CREATE TRIGGER `before_insert_or_update_formaciones`
BEFORE INSERT ON `formaciones`
FOR EACH ROW
BEGIN
  SET NEW.definicion = UPPER(NEW.definicion);
END$$

DELIMITER ;



--Respuestas a las preguntas:

--a)No hay operación posible con una sola tabla.

--b)
SELECT `id`, `nombre`, `definicion`, `empresario` FROM `formaciones`
WHERE `nombre` LIKE '%Ingles%'
UNION
SELECT `id`, `nombre`, `definicion`, `empresario`FROM `formaciones`
WHERE `empresario = 'Fernando'`;

--c)No hay operación posible con una sola tabla.

--d)
SELECT COUNT(f.nombre) FROM formaciones as f;

--e)No hay operación posible con una sola tabla.

--f)No hay operación posible con una sola tabla.

--g)No hay operación posible con una sola tabla.

--h)No hay operación posible con una sola tabla.

CREATE TABLE IF NOT EXISTS filiales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    email VARCHAR(100),
    id_sede INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO filiales (nombre, direccion, telefono, email, id_sede) VALUES
('Filial Norte 1', 'Calle Norte 456', '987654321', 'norte1@filial.com', 1),
('Filial Norte 2', 'Avenida Norte 789', '987654322', 'norte2@filial.com', 1),
('Filial Sur 1', 'Calle Sur 789', '654987321', 'sur1@filial.com', 2),
('Filial Sur 2', 'Avenida Sur 101', '654987322', 'sur2@filial.com', 2),
('Filial Este 1', 'Calle Este 123', '123456789', 'este1@filial.com', 3),
('Filial Este 2', 'Avenida Este 456', '123456790', 'este2@filial.com', 3),
('Filial Oeste 1', 'Calle Oeste 789', '321654987', 'oeste1@filial.com', 4),
('Filial Oeste 2', 'Avenida Oeste 101', '321654988', 'oeste2@filial.com', 4),
('Filial Central 1', 'Calle Central 456', '741852963', 'central1@filial.com', 1),
('Filial Central 2', 'Avenida Central 789', '741852964', 'central2@filial.com', 1);

DELIMITER //
CREATE TRIGGER before_insert_filiales
BEFORE INSERT ON filiales
FOR EACH ROW
BEGIN
    IF NEW.telefono REGEXP '[^0-9]' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El número de teléfono debe contener solo números.';
    END IF;
END;
//
DELIMITER ;

Pregunta 3 
a)Interseccion entre la tabla sedes y filiales
SELECT nombre, email FROM alumnos
INTERSECT
SELECT nombre, email FROM profesores;

b)Union entre la tabla sedes y filiales
SELECT nombre, id_sede 
FROM filiales
UNION
SELECT nombre_departamento AS nombre, nombre_departamento AS id_sede
FROM sedes;

c)
SELECT nombre, id_sede 
FROM filiales
EXCEPT
SELECT nombre_departamento AS nombre, nombre_departamento AS id_sede
FROM sedes;

d)
SELECT id_sede, COUNT(*) AS cantidad_filiales
FROM filiales
GROUP BY id_sede;

e)
SELECT *
FROM filiales
NATURAL JOIN sedes;

f)
SELECT f.nombre, f.id_sede, s.nombre_departamento, s.presupuesto
FROM filiales f
LEFT JOIN sedes s ON f.id_sede = s.nombre_departamento;

g)
SELECT f.nombre, f.id_sede, s.nombre_departamento, s.presupuesto
FROM filiales f
RIGHT JOIN sedes s ON f.id_sede = s.nombre_departamento;

h)
SELECT f.nombre, f.direccion, f.telefono, f.email, s.nombre_departamento, s.edificio, s.presupuesto
FROM filiales f
CROSS JOIN sedes s;

