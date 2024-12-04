
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


