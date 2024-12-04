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
('English', 'Uneatlantico', '90000.00'),
