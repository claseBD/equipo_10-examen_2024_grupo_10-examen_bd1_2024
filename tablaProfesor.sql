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




