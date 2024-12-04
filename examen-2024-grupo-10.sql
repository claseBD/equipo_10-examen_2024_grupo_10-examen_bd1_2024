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

