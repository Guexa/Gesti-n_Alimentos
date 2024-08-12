# Gestión de Alimentos

Este es un trabajo que incluye un CRUD completo para la gestión de un restaurante usando FLUTTER y metodología MVVM

## Pasos para ejecutar el programa

- Descargamos el ZIP
- Nos trasladamos a https://supabase.com/ e iniciamos sesión de la forma que querramos
- Crearémos un nuevo proyecto que se cargará con las tablass y datos proporcionados a continuación (Esta DBS puede tener cualquier nombre)
- Guardar en un bloc de notas la url de la base de datos y su anon key
- Una vez generada la base de datos nos irémos del lado derecho al apartado SQL Editor y vamos a generar dos scripts diferentes

### Script de la Base de Datos

```
CREATE TABLE Usuario (
    idUsuario serial PRIMARY KEY,
    name VARCHAR(255),
    users VARCHAR(255),
    role VARCHAR(255),
    password VARCHAR(255)
);

CREATE TABLE Mesa (
    idMesa serial PRIMARY KEY,
    status VARCHAR(255),
    asignada_para VARCHAR(255)
);

CREATE TABLE Menu (
    idMenu serial PRIMARY KEY,
    categoria VARCHAR(255),
    nombre VARCHAR(255),
    precio NUMERIC,
    opciones VARCHAR(255)
);

CREATE TABLE Orden (
    idOrden serial PRIMARY KEY,
    idMesa INTEGER REFERENCES Mesa(idMesa),
    items TEXT,
    total NUMERIC,
    status VARCHAR(255)
);

CREATE TABLE Reporte (
    idReporte UUID PRIMARY KEY,
    tipo VARCHAR(255),
    fecha TIMESTAMP,
    data TEXT
);
```

### Script de poblado de datos

```

-- Datos iniciales para la tabla Usuario
INSERT INTO Usuario (name, users, role, password) VALUES 
('Raquel Ramirez Flores', 'rramirez', 'Host', 'Qwerty123456'),
('Emilio Guerrero Lopez', 'eguerrero', 'Cocina', 'Qwerty123456'),
('Mesero 1', 'mesero1', 'Mesero', 'Qwerty123456'),
('Mesero 2', 'mesero2', 'Mesero', 'Qwerty123456'),
('Mesero 3', 'mesero3', 'Mesero', 'Qwerty123456'),
('Mesero 4', 'mesero4', 'Mesero', 'Qwerty123456'),
('Corredor 1', 'corredor1', 'Corredor', 'Qwerty123456'),
('Corredor 2', 'corredor2', 'Corredor', 'Qwerty123456'),
('Corredor 3', 'corredor3', 'Corredor', 'Qwerty123456'),
('Corredor 4', 'corredor4', 'Corredor', 'Qwerty123456'),
('Citlalli Martinez Medina', 'cmartinez', 'Caja', 'Qwerty123456'),
('Alexa Guerrero Lopez', 'aguerrero', 'Administrador', 'Qwerty123456');

-- Datos iniciales para la tabla Mesa
DO $$ 
BEGIN
    FOR i IN 1..20 LOOP
        INSERT INTO Mesa (status, asignada_para) VALUES ('Libre', '');
    END LOOP;
END $$;

-- Datos iniciales para la tabla Menu
INSERT INTO Menu (categoria, nombre, precio, opciones) VALUES 
('Comida', 'EMPANADAS DE PASTA DE HOJALDRE', 45.0, 'Queso con chorizo, Hawaiana, Pepperoni'),
('Comida', 'BAGUETTE DE POLLO', 65.0, 'Mayonesa, Chipotle, Cesar'),
('Comida', 'ORDEN DE NACHOS', 45.0, ''),
('Postres', 'BROWNIE CON HELADO', 35.0, ''),
('Postres', 'CREPA DE NUTELLA', 50.0, 'Platano, Fresa, Philadelphia'),
('Postres', 'CREPA DE LECHERA', 50.0, 'Platano, Fresa, Philadelphia'),
('Bebidas', 'PIÑADA', 60.0, ''),
('Bebidas', 'MALTEADA DE FRESA', 60.0, 'Entera, Deslactosada, Chocolate Liquido, Crema Batida'),
('Bebidas', 'MALTEADA DE VAINILLA', 60.0, 'Entera, Deslactosada, Chocolate Liquido, Crema Batida'),
('Bebidas', 'MALTEADA DE CHOCOLATE', 60.0, 'Entera, Deslactosada, Chocolate Liquido, Crema Batida'),
('Bebidas', 'FRAPPE MOKA', 55.0, 'Entera, Deslactosada, Chocolate Liquido, Crema Batida'),
('Bebidas', 'FRAPPE OREO', 60.0, 'Entera, Deslactosada, Chocolate Liquido, Crema Batida'),
('Bebidas', 'REFRESCOS', 25.0, 'Coca Cola, Coca Cola Light, Manzana, Sprite');

-- Orden 1: Incluye opciones para las comidas y bebidas seleccionadas
INSERT INTO Orden (idMesa, items, total, status) VALUES 
(1, 'EMPANADAS DE PASTA DE HOJALDRE Queso con chorizo, BAGUETTE DE POLLO Mayonesa, BROWNIE CON HELADO', 145.0, 'Pedido');

-- Orden 2: Incluye opciones para una malteada con sus diferentes opciones
INSERT INTO Orden (idMesa, items, total, status) VALUES 
(2, 'MALTEADA DE FRESA Entera, MALTEADA DE VAINILLA Deslactosada, PIÑADA', 180.0, 'Completada');

-- Orden 3: Incluye opciones para bebidas y un postre con opciones
INSERT INTO Orden (idMesa, items, total, status) VALUES 
(3, 'MALTEADA DE CHOCOLATE Entera, FRAPPE MOKA Crema Batida, CREPA DE NUTELLA Platano, Fresa', 145.0, 'Pedido');

-- Orden 4: Solo comida sin opciones
INSERT INTO Orden (idMesa, items, total, status) VALUES 
(4, 'ORDEN DE NACHOS, BAGUETTE DE POLLO', 110.0, 'Pedido');

-- Orden 5: Varias bebidas con opciones
INSERT INTO Orden (idMesa, items, total, status) VALUES 
(5, 'MALTEADA DE FRESA Chocolate Liquido, FRAPPE OREO Entera, REFRESCOS Coca Cola, Sprite', 180.0, 'Pedido');
```

- Ya que se haya generado los dos scripts volverémos a VS Code en donde se nuestra la clase main.dart y agregaremos nuestra url y anonKey en sus respectivos campos:

```
await Supabase.initialize(
    url: 'https://su-url.supabase.co',
    anonKey: 'Su anon key',
  );
```

- Una vez ejecutados estos pasos podrá correr de manera satisfactoria el proyecto gestion-alimentos.

ATT: Guexa_ :D
