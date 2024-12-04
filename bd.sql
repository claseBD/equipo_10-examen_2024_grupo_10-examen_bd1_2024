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

SELECT 
  nombre_departamento
FROM 
  sedes

EXCEPT

SELECT 
  asignatura
FROM 
  profesor;

-- Reunion Natural
SELECT *
FROM sedes
NATURAL JOIN profesor;

-- Informacion ausente por la izquierda

SELECT 
  s.nombre_departamento,
  s.edificio,
  s.presupuesto
FROM 
  sedes s
LEFT JOIN 
  profesor p
ON 
  s.nombre_departamento = p.asignatura
WHERE 
  p.asignatura IS NULL;


-- Informacion ausente por la derecha
SELECT 
  p.ID,
  p.nombre,
  p.asignatura,
  p.salario
FROM 
  sedes s
RIGHT JOIN 
  profesor p
ON 
  s.nombre_departamento = p.asignatura
WHERE 
  s.nombre_departamento IS NULL;


-- Producto cartesiano
SELECT *
FROM tabla1
CROSS JOIN tabla2;
