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
