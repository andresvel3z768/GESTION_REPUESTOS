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
	Email_Empleado VARCHAR(100),  -- Correo electrónico
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
    Teléfono VARCHAR(15),  -- Número de teléfono
    EmpleadoDetalleID INT,  -- Relación con la tabla EmpleadoDetalles
    FOREIGN KEY (EmpleadoDetalleID) REFERENCES EmpleadoDetalles(EmpleadoDetalleID)  -- Relación con los detalles del empleado
);

CREATE TABLE Distribuidores (
    ProveedorID VARCHAR(100) PRIMARY KEY,  
    Nombre VARCHAR(100) NOT NULL,  -- Nombre del proveedor
    Teléfono VARCHAR(15),  -- Teléfono de contacto
    Email VARCHAR(100),  -- Correo electrónico
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
    DescripcionPerfil VARCHAR(100) NOT NULL
);

CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY IDENTITY(1,1),
	Documento_Trabajador VARCHAR(100),
    UsuarioNombre VARCHAR(50) UNIQUE NOT NULL,
    Contraseña VARCHAR(255) NOT NULL,  -- Contraseña encriptada
    Activo BIT NOT NULL DEFAULT 1,
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

