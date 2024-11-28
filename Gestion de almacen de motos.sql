CREATE DATABASE Gestion_Repuestos
GO
USE Gestion_Repuestos

CREATE TABLE Clientes (
    Documento_Cliente Nvarchar(100) PRIMARY KEY,
    NombreCliente VARCHAR(100) NOT NULL,
    DireccionCliente VARCHAR(255),
    TelefonoCliente VARCHAR(50),
    CorreoCliente VARCHAR(100),
    FechaRegistro DATE NOT NULL 
);

CREATE TABLE EmpleadoDetalles (
    EmpleadoDetalleID INT PRIMARY KEY IDENTITY(1,1),  -- Identificador único para los detalles del empleado
	Email_Empleado VARCHAR(100) UNIQUE,  -- Correo electrónico
	Dirección_Empleado VARCHAR(255),  -- Dirección de residencia
    Salario DECIMAL(10, 2),  -- Salario mensual
    FechaContratacion DATE,  -- Fecha de contratación
    EstadoEmpleado VARCHAR(20),  -- Estado del empleado (ej. "activo", "inactivo", "licencia")
    FechaSalida DATE  -- Fecha de salida si el empleado deja la empresa
);

CREATE TABLE Empleados (
    Documento_Trabajador Varchar(100) PRIMARY KEY ,  -- Identificador único del empleado
    Nombre VARCHAR(100) NOT NULL,  -- Nombre completo del empleado
    Apellido VARCHAR(100),  -- Apellido del empleado
    FechaNacimiento DATE,  -- Fecha de nacimiento
    Teléfono VARCHAR(15)UNIQUE,  -- Número de teléfono
    EmpleadoDetalleID INT NOT NULL,  -- Relación con la tabla EmpleadoDetalles
    FOREIGN KEY (EmpleadoDetalleID) REFERENCES EmpleadoDetalles(EmpleadoDetalleID)  -- Relación con los detalles del empleado
);

CREATE TABLE Distribuidores (
    ProveedorID VARCHAR(100) PRIMARY KEY,  
    Nombre VARCHAR(100) NOT NULL,  -- Nombre del proveedor
    Teléfono VARCHAR(15)UNIQUE,  -- Teléfono de contacto
    Email VARCHAR(100)UNIQUE,  -- Correo electrónico
    Dirección VARCHAR(255),  -- Dirección física del proveedor
    Contacto VARCHAR(100),  -- Persona de contacto
    FechaRegistro DATE,  -- Fecha en que el proveedor fue registrado
    Estado VARCHAR(20)  -- Estado del proveedor (ej. "activo", "inactivo")
);

CREATE TABLE Repuestos (
    RepuestoID INT PRIMARY KEY IDENTITY(1,1),
	ProveedorID VARCHAR(100),
    NombreRepuesto VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    Precio DECIMAL(10, 2) NOT NULL,
    CantidadDisponible INT NOT NULL,
	FOREIGN KEY (ProveedorID) REFERENCES Distribuidores(ProveedorID)
);

CREATE TABLE Cargos (
    CargoID INT PRIMARY KEY IDENTITY(1,1),
    NombreCargo VARCHAR(100) NOT NULL
);

CREATE TABLE Perfiles (
    PerfilID INT PRIMARY KEY IDENTITY(1,1),
    DescripcionPerfil VARCHAR(100) NOT NULL,
	PaginaNavegacion NVARCHAR(255)
);

CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY IDENTITY(1,1),
	Documento_Trabajador VARCHAR(100),
    UsuarioNombre VARCHAR(50) UNIQUE NOT NULL,
    Contraseña VARCHAR(255) NOT NULL,  -- Contraseña encriptada
    Salt Nvarchar(2000),
	FOREIGN KEY (Documento_Trabajador) REFERENCES Empleados(Documento_Trabajador)
);

CREATE TABLE Ventas (
    VentaID INT PRIMARY KEY IDENTITY(1,1),  
    ClienteID NVARCHAR(100),  -- Relación con la tabla de Clientes
    TrabajadorID VARCHAR(100),  -- Relación con la tabla de Trabajadores
    FechaVenta DATE,  -- Fecha de la venta
	
	FOREIGN KEY (ClienteID) REFERENCES Clientes(Documento_Cliente),
	FOREIGN KEY (TrabajadorID) REFERENCES Empleados(Documento_Trabajador)
);

CREATE TABLE Compras(
    CompraID INT PRIMARY KEY IDENTITY(1,1),
	RepuestoID INT,
    ClienteID NVARCHAR(100),  -- Relacionado con el cliente que realiza la compra
    FechaCompra DATE NOT NULL,
    MontoTotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(Documento_Cliente),
	FOREIGN KEY (RepuestoID) REFERENCES Repuestos(RepuestoID)
);

CREATE TABLE DetalleVentas (
    DetalleVentaID INT PRIMARY KEY IDENTITY(1,1),
    VentaID INT,  -- Relación con la tabla de Ventas
    RepuestoID INT,  -- Relación con la tabla de Repuestos
    Cantidad INT,  -- Cantidad vendida
    PrecioUnitario DECIMAL(10, 2),  -- Precio del repuesto al momento de la venta
    Subtotal DECIMAL(10, 2)  -- Subtotal de la venta (Cantidad * PrecioUnitario)
	FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID),
	FOREIGN KEY (RepuestoID) REFERENCES Repuestos(RepuestoID)
);

CREATE TABLE CompraRepuestos (
    CompraRepuestoID INT PRIMARY KEY IDENTITY(1,1),
    CompraID INT,  -- Relacionado con la compra realizada
    RepuestoID INT,  -- Relacionado con el repuesto comprado
    Cantidad INT NOT NULL,  -- Cuántos repuestos se compraron
    PrecioUnitario DECIMAL(10, 2) NOT NULL,  -- Precio del repuesto al momento de la compra
    FOREIGN KEY (CompraID) REFERENCES Compras(CompraID),
    FOREIGN KEY (RepuestoID) REFERENCES Repuestos(RepuestoID)
);

CREATE TABLE Pagos (
    PagoID INT PRIMARY KEY IDENTITY(1,1),
    VentaID INT,  -- Relación con la tabla de Ventas
    Monto DECIMAL(10, 2),  -- Monto pagado
    FechaPago DATE,  -- Fecha del pago
    MétodoPago VARCHAR(50),  -- Método de pago (ej. "efectivo", "tarjeta")
    EstadoPago VARCHAR(50),  -- Estado del pago (ej. "completo", "parcial")
    Referencia VARCHAR(100), -- Referencia de la transacción (si aplica)
	FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID)
);

CREATE TABLE Factura (
    FacturaID INT PRIMARY KEY IDENTITY(1,1),
    ClienteID NVARCHAR(100),  -- Relacionado con el cliente que recibe la factura
    EmpleadoID VARCHAR(100),  -- Relacionado con el empleado que emite la factura
    FechaEmision DATE NOT NULL ,
	Garantia_Servicio INT, --garantias del serivicio 
	PagoID INT,--El metodo de pago 
    FOREIGN KEY (ClienteID) REFERENCES Clientes(Documento_Cliente),
    FOREIGN KEY (EmpleadoID) REFERENCES Empleados(Documento_Trabajador),-- Relación con el empleado
	FOREIGN KEY (PagoID) REFERENCES Pagos(PagoID) --Relacion con Pagos
);

CREATE TABLE TipoGarantias (
    TipoGarantiaID INT PRIMARY KEY IDENTITY(1,1),
    DescripcionTipoGarantia VARCHAR(100) NOT NULL,
	Periodo_Garantia varchar(100)
);

CREATE TABLE Garantias (
    GarantiaID INT PRIMARY KEY IDENTITY(1,1),
    FacturaID INT,  -- Relacionado con la factura en la que se otorga la garantía
    TipoGarantiaID INT,  -- Relacionado con el tipo de garantía
    FechaInicio DATE NOT NULL,  -- Fecha en la que comienza la garantía
    FOREIGN KEY (FacturaID) REFERENCES Factura(FacturaID),
    FOREIGN KEY (TipoGarantiaID) REFERENCES TipoGarantias(TipoGarantiaID)
);

CREATE TABLE EmpleadoCargo (
    EmpleadoID VARCHAR(100),
    CargoID INT,
    FechaAsignacion DATE NOT NULL,
    PRIMARY KEY (EmpleadoID, CargoID),
    FOREIGN KEY (EmpleadoID) REFERENCES Empleados(Documento_Trabajador),
    FOREIGN KEY (CargoID) REFERENCES Cargos(CargoID)
);

CREATE TABLE UsuarioPerfil (
    UsuarioID INT,
    PerfilID INT,
    Activo BIT NOT NULL DEFAULT 1,
    PRIMARY KEY (UsuarioID, PerfilID),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (PerfilID) REFERENCES Perfiles(PerfilID)
);


/*CREACION DE VALORES DE LAS TABLAS DE LA BASE DE DATOS */
INSERT INTO Clientes (Documento_Cliente, NombreCliente, DireccionCliente, TelefonoCliente, CorreoCliente, FechaRegistro)
VALUES 
('123456789', 'Juan Pérez', 'Calle Falsa 123', '555-1234', 'juan.perez@example.com', '2024-11-01'),
('987654321', 'María González', 'Av. Principal 45', '555-5678', 'maria.gonzalez@example.com', '2024-11-02'),
('456789123', 'Carlos Ramírez', 'Barrio Norte 88', '555-9876', 'carlos.ramirez@example.com', '2024-11-03'),
('654321987', 'Ana Torres', 'Zona Sur 100', '555-4567', 'ana.torres@example.com', '2024-11-04'),
('112233445', 'Pedro López', 'Av. del Sol 55', '555-1122', 'pedro.lopez@example.com', '2024-11-05'),
('223344556', 'Lucía Sánchez', 'Calle Luna 98', '555-3344', 'lucia.sanchez@example.com', '2024-11-06'),
('334455667', 'Roberto Díaz', 'Zona Central 23', '555-7788', 'roberto.diaz@example.com', '2024-11-07'),
('445566778', 'Laura Vega', 'Av. Verde 17', '555-4455', 'laura.vega@example.com', '2024-11-08'),
('556677889', 'Ricardo Herrera', 'Calle Roja 72', '555-6677', 'ricardo.herrera@example.com', '2024-11-09'),
('667788990', 'Gabriela Molina', 'Plaza Azul 50', '555-2233', 'gabriela.molina@example.com', '2024-11-10'),
('778899001', 'Jorge Castro', 'Av. Amarilla 33', '555-9988', 'jorge.castro@example.com', '2024-11-11'),
('889900112', 'Paola Cruz', 'Zona Este 67', '555-7789', 'paola.cruz@example.com', '2024-11-12'),
('990011223', 'Miguel Ángel', 'Barrio Oeste 101', '555-8890', 'miguel.angel@example.com', '2024-11-13'),
('001122334', 'Sofía Romero', 'Calle Blanca 34', '555-3345', 'sofia.romero@example.com', '2024-11-14'),
('112233556', 'Daniela Vargas', 'Av. Negra 89', '555-6678', 'daniela.vargas@example.com', '2024-11-15');
GO

INSERT INTO EmpleadoDetalles (Email_Empleado, Dirección_Empleado, Salario, FechaContratacion, EstadoEmpleado, FechaSalida)
VALUES
('juan.perez@empresa.com', 'Calle Falsa 123', 1500.50, '2023-01-15', 'activo', NULL),
('maria.gomez@empresa.com', 'Av. Principal 45', 2000.00, '2022-05-10', 'licencia', NULL),
('carlos.ramirez@empresa.com', 'Barrio Norte 88', 1800.75, '2021-03-20', 'inactivo', '2023-08-01'),
('ana.torres@empresa.com', 'Zona Sur 100', 2200.30, '2020-11-10', 'activo', NULL),
('pedro.lopez@empresa.com', 'Av. del Sol 55', 1750.00, '2023-03-01', 'activo', NULL),
('lucia.sanchez@empresa.com', 'Calle Luna 98', 1900.80, '2021-12-15', 'inactivo', '2024-01-10'),
('roberto.diaz@empresa.com', 'Zona Central 23', 2100.00, '2022-08-05', 'licencia', NULL),
('laura.vega@empresa.com', 'Av. Verde 17', 1950.60, '2023-06-01', 'activo', NULL),
('ricardo.herrera@empresa.com', 'Calle Roja 72', 2050.25, '2020-09-10', 'activo', NULL),
('gabriela.molina@empresa.com', 'Plaza Azul 50', 1850.90, '2021-10-15', 'inactivo', '2023-12-20'),
('jorge.castro@empresa.com', 'Av. Amarilla 33', 1750.75, '2023-04-01', 'licencia', NULL),
('paola.cruz@empresa.com', 'Zona Este 67', 1600.40, '2020-05-12', 'activo', NULL),
('miguel.angel@empresa.com', 'Barrio Oeste 101', 2300.00, '2022-03-20', 'activo', NULL),
('sofia.romero@empresa.com', 'Calle Blanca 34', 2200.50, '2021-01-10', 'licencia', NULL),
('daniela.vargas@empresa.com', 'Av. Negra 89', 2100.30, '2020-06-25', 'inactivo', '2023-02-15');
GO

INSERT INTO Empleados (Documento_Trabajador, Nombre, Apellido, FechaNacimiento, Teléfono, EmpleadoDetalleID)
VALUES
('123456789', 'Juan', 'Pérez', '1985-05-10', '5551234567', 1),
('987654321', 'María', 'Gómez', '1990-08-15', '5552345678', 2),
('456789123', 'Carlos', 'Ramírez', '1992-03-25', '5553456789', 3),
('654321987', 'Ana', 'Torres', '1988-12-01', '5554567890', 4),
('112233445', 'Pedro', 'López', '1975-07-20', '5555678901', 5),
('334455667', 'Lucía', 'Sánchez', '1995-10-30', '5556789012', 6),
('445566778', 'Roberto', 'Díaz', '1983-11-11', '5557890123', 7),
('556677889', 'Laura', 'Vega', '1998-04-22', '5558901234', 8),
('667788990', 'Ricardo', 'Herrera', '1980-06-18', '5559012345', 9),
('778899001', 'Gabriela', 'Molina', '1991-09-15', '5550123456', 10),
('889900112', 'Jorge', 'Castro', '1984-01-25', '5551234568', 11),
('990011223', 'Paola', 'Cruz', '1987-03-17', '5552345679', 12),
('001122334', 'Miguel', 'Ángel', '1989-12-05', '5553456780', 13),
('112233556', 'Sofía', 'Romero', '1993-07-14', '5554567891', 14),
('223344667', 'Daniela', 'Vargas', '1996-11-19', '5555678902', 15);
GO

INSERT INTO Distribuidores (ProveedorID, Nombre, Teléfono, Email, Dirección, Contacto, FechaRegistro, Estado)
VALUES
('1010101010', 'Distribuidora Alpha', '5551234567', 'contacto@alpha.com', 'Av. Central 123', 'Laura Gómez', '2023-01-15', 'activo'),
('2020202020', 'Suministros Beta', '5552345678', 'ventas@beta.com', 'Calle Norte 45', 'Carlos Ramírez', '2023-03-20', 'activo'),
('3030303030', 'Proveedora Gamma', '5553456789', 'info@gamma.com', 'Zona Industrial 88', 'Ana Torres', '2023-05-10', 'inactivo'),
('4040404040', 'Importaciones Delta', '5554567890', 'contacto@delta.com', 'Av. Sur 55', 'Ricardo Herrera', '2023-06-01', 'activo'),
('5050505050', 'Grupo Epsilon', '5555678901', 'contacto@epsilon.com', 'Plaza Comercial 67', 'Sofía Romero', '2023-07-25', 'activo'),
('6060606060', 'Distribuidora Zeta', '5556789012', 'ventas@zeta.com', 'Calle Verde 89', 'Miguel Ángel', '2023-08-10', 'activo'),
('7070707070', 'Proveedora Eta', '5557890123', 'info@eta.com', 'Zona Oeste 100', 'Daniela Vargas', '2023-09-15', 'inactivo'),
('8080808080', 'Suministros Theta', '5558901234', 'ventas@theta.com', 'Av. Amarilla 33', 'Jorge Castro', '2023-10-01', 'activo'),
('9090909090', 'Grupo Iota', '5559012345', 'info@iota.com', 'Calle Roja 72', 'Gabriela Molina', '2023-11-20', 'activo'),
('1111111111', 'Importaciones Kappa', '5550123456', 'contacto@kappa.com', 'Av. Negra 17', 'Laura Vega', '2023-12-05', 'activo'),
('1212121212', 'Distribuidora Lambda', '5551234568', 'info@lambda.com', 'Zona Este 45', 'Pedro López', '2023-12-10', 'inactivo'),
('1313131313', 'Suministros Mu', '5552345679', 'ventas@mu.com', 'Calle Blanca 34', 'María Gómez', '2023-12-12', 'activo'),
('1414141414', 'Proveedora Nu', '5553456780', 'info@nu.com', 'Plaza Azul 101', 'Lucía Sánchez', '2023-12-15', 'activo'),
('1515151515', 'Importaciones Xi', '5554567891', 'ventas@xi.com', 'Zona Central 90', 'Roberto Díaz', '2023-12-18', 'activo'),
('1616161616', 'Grupo Omicron', '5555678902', 'info@omicron.com', 'Calle Luna 50', 'Juan Pérez', '2023-12-20', 'activo');
GO

INSERT INTO Repuestos (ProveedorID, NombreRepuesto, Descripcion, Precio, CantidadDisponible)
VALUES
('1010101010', 'Aceite para motor', 'Aceite sintético de alta calidad', 120.50, 50),
('2020202020', 'Filtro de aire', 'Filtro compatible con modelos Honda', 45.75, 30),
('3030303030', 'Batería para motocicleta', 'Batería de larga duración', 350.00, 15),
('4040404040', 'Pastillas de freno', 'Juego de pastillas de freno delanteras', 89.99, 60),
('5050505050', 'Kit de transmisión', 'Incluye cadena, piñón y corona', 220.00, 25),
('6060606060', 'Llanta trasera', 'Llanta de alto rendimiento', 520.30, 10),
('7070707070', 'Casco integral', 'Casco certificado DOT', 150.00, 20),
('8080808080', 'Espejo retrovisor', 'Espejo derecho universal', 35.50, 40),
('9090909090', 'Luces LED', 'Luces LED para faros principales', 70.00, 100),
('1111111111', 'Manillar deportivo', 'Manillar ajustable de aluminio', 180.00, 12);
GO

INSERT INTO Cargos (NombreCargo)
VALUES
('Gerente'),
('Asistente'),
('Vendedor'),
('Jefe de almacén'),
('Supervisor'),
('Técnico'),
('Recepcionista'),
('Contador'),
('Coordinador de ventas'),
('Encargado de compras');
GO

INSERT INTO Perfiles (DescripcionPerfil, PaginaNavegacion)
VALUES
('Administrador', 'AdminDashboard.html'),
('Empleado', 'EmpleadoDashboard.html'),
('Gerente', 'GerenteDashboard.html'),
('Supervisor', 'SupervisorDashboard.html'),
('Tecnico', 'TecnicoDashboard.html'),
('Vendedor', 'VendedorDashboard.html'),
('Repartidor', 'RepartidorDashboard.html'),
('Contador', 'ContadorDashboard.html'),
('Jefe de almacén', 'JefeAlmacenDashboard.html'),
('Coordinador de ventas', 'CoordinadorVentas.html');
GO

INSERT INTO Ventas (ClienteID, TrabajadorID, FechaVenta)
VALUES
('001122334', '001122334', '2024-11-01'),
('112233445', '112233445', '2024-11-02'),
('112233556', '112233556', '2024-11-03'),
('123456789', '123456789', '2024-11-04'),
('223344556', '223344667', '2024-11-05'),
('334455667', '334455667', '2024-11-06'),
('445566778', '445566778', '2024-11-07'),
('456789123', '456789123', '2024-11-08'),
('556677889', '556677889', '2024-11-09'),
('654321987', '654321987', '2024-11-10'),
('667788990', '667788990', '2024-11-11'),
('778899001', '778899001', '2024-11-12'),
('889900112', '889900112', '2024-11-13'),
('987654321', '987654321', '2024-11-14'),
('990011223', '990011223', '2024-11-15');
GO

INSERT INTO Compras (RepuestoID, ClienteID, FechaCompra, MontoTotal)
VALUES
('1', '001122334', '2024-11-01', 120.50),
(2, '112233445', '2024-11-02', 250.00),
(3, '112233556', '2024-11-03', 99.99),
(4, '123456789', '2024-11-04', 320.25),
(5, '223344556', '2024-11-05', 150.75),
(6, '334455667', '2024-11-06', 80.00),
(7, '445566778', '2024-11-07', 210.90),
(8, '456789123', '2024-11-08', 300.10),
(9, '556677889', '2024-11-09', 400.25),
(10, '654321987', '2024-11-10', 250.50),
(5, '667788990', '2024-11-11', 175.00),
(7, '778899001', '2024-11-12', 450.75),
(3, '889900112', '2024-11-13', 320.00),
(1, '987654321', '2024-11-14', 275.30),
(2, '990011223', '2024-11-15', 530.60);
GO

INSERT INTO CompraRepuestos (CompraID, RepuestoID, Cantidad, PrecioUnitario)
VALUES 
(1, 2, 10, 50),
(7, 5, 15, 30),
(2, 6, 8, 75),
(3, 10, 12, 40),
(4, 9, 7, 50);
GO

INSERT INTO Pagos (VentaID, Monto, FechaPago, MétodoPago, EstadoPago, Referencia)
VALUES 
(1, 1000.00, '2023-11-28', 'Efectivo', 'Completo', 'Pago #001'),
(2, 500.00, '2023-11-27', 'Tarjeta de crédito', 'Parcial', 'Transacción #002'),
(3, 750.00, '2023-11-29', 'Depósito bancario', 'En espera', 'Referencia 003'),
(4, 200.00, '2023-11-30', 'Transferencia electrónica', 'Completo', 'Trf #004'),
(5, 1500.00, '2023-12-01', 'Cheque', 'En proceso', 'Chq #005'),
(6, 300.00, '2023-11-29', 'Efectivo', 'Completo', 'Pago en caja'),
(7, 800.00, '2023-11-28', 'Tarjeta de crédito', 'Parcial', 'Transacción #007'),
(8, 1200.00, '2023-12-02', 'Depósito bancario', 'Completo', 'Deposito #008'),
(9, 250.00, '2023-11-27', 'Transferencia electrónica', 'En espera', 'Trf #009'),
(10, 600.00, '2023-11-30', 'Cheque', 'Parcial', 'Chq #010');
GO
INSERT INTO Factura (ClienteID, EmpleadoID, FechaEmision, Garantia_Servicio, PagoID)
VALUES 
('001122334', '112233445', '2023-11-28', 30, 1),
('112233445', '112233556', '2023-11-27', 60, 2),
('112233556', '123456789', '2023-11-29', 90, 3),
('123456789', '223344667', '2023-11-30', 45, 4),
('445566778', '334455667', '2023-12-01', 120, 5),
('556677889', '445566778', '2023-11-28', 30, 6),
('987654321', '456789123', '2023-11-27', 75, 7),
('990011223', '556677889', '2023-11-29', 150, 8),
('334455667', '654321987', '2023-11-30', 90, 9),
('456789123', '889900112', '2023-12-01', 180, 10);
GO

INSERT INTO TipoGarantias (DescripcionTipoGarantia, Periodo_Garantia)
VALUES 
('Garantía Plástica', '12 meses'),
('Garantía de Reparación', '6 meses'),
('Garantía de Piezas', '3 meses'),
('Garantía de Servicio Completo', '24 meses'),
('Garantía de Componentes', '18 meses'),
('Garantía de Mantenimiento Preventivo', '12 meses'),
('Garantía de Funcionamiento', '6 meses'),
('Garantía de Calidad', '3 meses'),
('Garantía de Reemplazo Gratuito', '30 días'),
('Garantía de Soporte Técnico', '90 días');
GO

INSERT INTO Garantias (FacturaID, TipoGarantiaID, FechaInicio)
VALUES 
(1, 1, '2023-11-28'),  -- Garantía de 12 meses para la factura 1
(2, 2, '2023-11-27'),  -- Garantía de 6 meses para la factura 2
(3, 3, '2023-11-29'),  -- Garantía de 3 meses para la factura 3
(4, 1, '2023-11-30'),  -- Garantía de 12 meses para la factura 4
(5, 4, '2023-12-01'),  -- Garantía de 24 meses para la factura 5
(1, 5, '2023-11-28'),  -- Garantía de 18 meses para la factura 1
(6, 6, '2023-11-27'),  -- Garantía de 12 meses para la factura 6
(7, 7, '2023-11-29'),  -- Garantía de 6 meses para la factura 7
(8, 8, '2023-11-30'),  -- Garantía de 3 meses para la factura 8
(9, 9, '2023-12-01');  -- Garantía de 30 días para la factura 9
GO

INSERT INTO EmpleadoCargo (EmpleadoID, CargoID, FechaAsignacion)
VALUES
    ('223344667', 1, '2024-11-01' ),
    ('334455667', 2, '2024-11-02'),
    ('445566778', 3, '2024-11-03'),
    ('556677889', 4, '2024-11-04'),
    ('456789123', 5, '2024-11-05'),
    ('654321987', 6, '2024-11-06'),
    ('987654321', 7, '2024-11-07'),
    ('667788990', 8, '2024-11-08'),
    ('889900112', 9, '2024-11-09'),
    ('778899001', 10, '2024-11-10');GO

INSERT INTO Usuarios (Documento_Trabajador, UsuarioNombre, Contraseña, Salt)
VALUES 
    ('223344667', 'johndoe', 'hashedpassword1', 'randomSaltValue1'),
    ('334455667', 'janedoe', 'hashedpassword2', 'randomSaltValue2'),
    ('112233556', 'mikejones', 'hashedpassword3', 'randomSaltValue3');
go

INSERT INTO UsuarioPerfil (UsuarioID, PerfilID, Activo)
VALUES
    (1, 1, 1),  -- User 1 assigned to Profile 1, active
    (2, 2, 1),  -- User 2 assigned to Profile 2, active
    (3, 1, 0),  -- User 3 assigned to Profile 1, inactive
    (4, 3, 1);  -- User 4 assigned to Profile 3, active
