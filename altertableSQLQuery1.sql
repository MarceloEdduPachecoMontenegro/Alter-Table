-- Creación de base de datos
CREATE DATABASE QLTERTABLE
CREATE TABLE ESTUDIANTES (
    ID_ESTUDIANTE INT PRIMARY KEY, -- En SQL Server, se usa INT para los números enteros
    NOMBRE VARCHAR(100), -- En SQL Server, se usa VARCHAR en lugar de VARCHAR2
    APELLIDO VARCHAR(100),
    EMAIL VARCHAR(100) UNIQUE,
    FECHA_NACIMIENTO DATE
);

CREATE TABLE CURSOS (
    ID_CURSO INT PRIMARY KEY, -- En SQL Server, se usa INT para los números enteros
    NOMBRE_CURSO VARCHAR(100),
    DESCRIPCION VARCHAR(255),
    DURACION INT, -- Duración en horas, se utiliza INT para la duración
    PRECIO DECIMAL(10, 2) -- En SQL Server, se usa DECIMAL en lugar de NUMBER
);

CREATE TABLE INSCRIPCIONES (
    ID_INSCRIPCION INT PRIMARY KEY,
    ID_ESTUDIANTE INT,
    ID_CURSO INT,
    FECHA_INSCRIPCION DATE,
    CALIFICACION INT,
    CONSTRAINT FK_ESTUDIANTE FOREIGN KEY (ID_ESTUDIANTE) REFERENCES ESTUDIANTES(ID_ESTUDIANTE),
    CONSTRAINT FK_CURSO FOREIGN KEY (ID_CURSO) REFERENCES CURSOS(ID_CURSO)
);

-- Modificar la tabla ESTUDIANTES para agregar la columna DIRECCION
ALTER TABLE ESTUDIANTES ADD DIRECCION VARCHAR(200);

-- Modificar la columna DURACION de la tabla CURSOS (No es necesario modificar con tipo NUMBER en SQL Server)
-- En SQL Server, el tipo de datos INT es suficiente, ya que no tiene un número decimal.

-- Cambiar el nombre de la columna CALIFICACION a PUNTUACION
EXEC sp_rename 'INSCRIPCIONES.CALIFICACION', 'PUNTUACION', 'COLUMN';

-- Agregar una restricción de CHECK para la fecha de nacimiento en ESTUDIANTES (Verifica si la fecha de nacimiento es anterior a 192 años de la fecha actual)
ALTER TABLE ESTUDIANTES ADD CONSTRAINT CK_FECHA_NACIMIENTO CHECK (FECHA_NACIMIENTO <= DATEADD(YEAR, -192, GETDATE()));

-- Agregar una restricción UNIQUE a la columna NOMBRE_CURSO en CURSOS
ALTER TABLE CURSOS ADD CONSTRAINT UQ_NOMBRE_CURSO UNIQUE (NOMBRE_CURSO);

-- Modificar la columna PRECIO en CURSOS para asegurarse de que sea mayor o igual a 0 (En SQL Server, el tipo de datos DECIMAL(10, 2) es correcto)
ALTER TABLE CURSOS ADD CONSTRAINT CK_PRECIO CHECK (PRECIO >= 0);

-- Eliminar la columna FECHA_NACIMIENTO en ESTUDIANTES
ALTER TABLE ESTUDIANTES DROP COLUMN FECHA_NACIMIENTO;

-- Habilitar y deshabilitar restricciones (En SQL Server no se usa DISABLE/ENABLE, pero se puede hacer usando la opción WITH CHECK y WITH NOCHECK)
-- Deshabilitar la restricción UNIQUE en CURSOS
ALTER TABLE CURSOS NOCHECK CONSTRAINT UQ_NOMBRE_CURSO;

-- Habilitar la restricción UNIQUE en CURSOS
ALTER TABLE CURSOS WITH CHECK CHECK CONSTRAINT UQ_NOMBRE_CURSO;