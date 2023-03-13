CREATE DATABASE Bar2
go
USE Bar2
go

-------------------------------------------------------

CREATE TABLE Producto
(
    id int PRIMARY KEY IDENTITY (1,1) not null ,
    nombre varchar(25) null,
    valor DECIMAL(10)
)

CREATE TABLE Tipo_Empleado
(
    id int PRIMARY KEY IDENTITY (1,1) not null ,
    nombre VARCHAR(20)
)

CREATE TABLE Mesa
(
    id int PRIMARY KEY IDENTITY (1,1) not null ,
    numero SMALLINT NULL
)

CREATE TABLE Sede
(
    id int PRIMARY KEY IDENTITY (1,1) not null ,
    nombre VARCHAR(30) null,
    direccion VARCHAR(30) null,
    telefono int null,
)

CREATE TABLE Proveedor
(
    id int PRIMARY KEY IDENTITY (1,1) not null ,
    nombres VARCHAR(30) null,
    apellidos VARCHAR(30) null,
    correo VARCHAR(30) null,
    direccion VARCHAR(30) null,
    telefono int null,
)

-------------------------------------------------------

CREATE TABLE Empleado
(   
    id int PRIMARY KEY IDENTITY (1,1) not null ,
    nombres VARCHAR(30) null,
    apellidos VARCHAR(30) null,
    correo VARCHAR(30) null,
    direccion VARCHAR(30) null,
    telefono int null,
    estado int null,
    tipo_empleado_id int not null,
    sede_id int not null
    FOREIGN KEY (tipo_empleado_id) REFERENCES Tipo_Empleado(id),
    FOREIGN KEY (sede_id) REFERENCES Sede(id)
)

CREATE TABLE Venta
(
    id INT PRIMARY KEY IDENTITY (1,1) not NULL,
    fecha DATETIME,
    Mesa_id int,
    Sede_id int,
    Estado SMALLINT,
    FOREIGN KEY (Mesa_id) REFERENCES Mesa(id),
    FOREIGN KEY (Sede_id) REFERENCES Sede(id)
)

CREATE TABLE Venta_Producto
(
    id int PRIMARY KEY IDENTITY (1,1) not null ,
    Venta_id int,
    Producto_id int,
    Cantidad int,
    FOREIGN KEY (Venta_id) REFERENCES Venta(id),
    FOREIGN KEY (Producto_id) REFERENCES Producto(id)
)

CREATE TABLE Precio
(
    id int PRIMARY KEY IDENTITY (1,1) not null ,
    Producto_id int,
    Proveedor_id int,
    Precio_venta DECIMAL(15),
    Precio_compra DECIMAL(15),
    Fecha_inicio DATETIME,
    Fecha_final DATETIME,
    FOREIGN KEY (Producto_id) REFERENCES Producto(id)
)

CREATE TABLE Produto_Sede
(
    id int PRIMARY KEY IDENTITY (1,1) not null ,
    Producto_id int,
    Sede_id int,
    Cantidad int,
    FOREIGN KEY (Producto_id) REFERENCES Producto(id),
    FOREIGN KEY (Sede_id) REFERENCES Sede(id)
)

CREATE TABLE Proveedor_Producto
(
    id int PRIMARY KEY IDENTITY (1,1) not null ,
    Proveedor_id int,
    Producto_id int,
    Precio_compra DECIMAL(10),
    FOREIGN KEY (Proveedor_id) REFERENCES Proveedor(id),
    FOREIGN KEY (Producto_id) REFERENCES Producto(id)
)

-----------------------------------------------------------------

alter TABLE Precio add Proveedor_id int



-----------------------------------------------------------------
use master
drop DATABASE Bar

drop table Sede
drop table Mesa
drop table Tipo_Empleado
drop table Producto
drop table Proveedor
drop table Empleado
drop table Venta
drop table Venta_Producto
drop TABLE Precio
drop TABLE Produto_Sede
drop TABLE Proveedor_Producto

-----------------------------------------------------------------


use Bar2
GO

-- Triggers Proveedor_Producto

create TRIGGER TR_PrecioInsertado_Proveedor
ON dbo.Proveedor_Producto FOR insert
AS
declare @Precio_compra decimal(10)
select @Precio_compra = Precio_compra from inserted
declare @Proveedor_id int
select @Proveedor_id = Proveedor_id from inserted
declare @id INT
select @id = Producto_id from inserted
update Precio set Fecha_final=DATEADD(ms,-3,dateadd(dd,DATEDIFF(dd,0,GETDATE()),0))
WHERE Producto_id=@id and Fecha_final IS NULL
insert into Precio VALUES(@id,@Proveedor_id,(select Valor from Producto where id=@id),@Precio_compra,dateadd(dd,DATEDIFF(dd,0,GETDATE()),0),null)
GO

create TRIGGER TR_PrecioAlterado_Proveedor
ON dbo.Proveedor_Producto FOR update
AS
declare @Precio_compra decimal(10)
select @Precio_compra = Precio_compra from inserted
declare @id INT
select @id = Producto_id from inserted
declare @Proveedor_id int 
select @Proveedor_id = Proveedor_id from inserted
update Precio set Fecha_final= DATEADD(ms,-3,dateadd(dd,DATEDIFF(dd,0,GETDATE()),0))
WHERE Producto_id=@id and Fecha_final IS NULL
insert into Precio VALUES(@id,@Proveedor_id,(select Valor from Producto where id=@id),@Precio_compra,dateadd(dd,DATEDIFF(dd,0,GETDATE()),0),Null)
--(select max(Producto_id) from Precio where Producto_id=2) -> Sobra
GO

-- Triggers Producto


create TRIGGER TR_PrecioInsertado_Producto
ON dbo.Producto FOR insert
AS
declare @Precio_compra decimal(10)
select @Precio_compra = Valor from inserted
declare @id INT
select @id = Id from inserted
if ((select Precio_compra from Proveedor_Producto where Producto_id=@id)is not null)
BEGIN
insert into Precio VALUES(@id,@id,@Precio_compra,(select Precio_compra from Proveedor_Producto where Producto_id=@id),dateadd(dd,DATEDIFF(dd,0,GETDATE()),0),null)
END
GO

create TRIGGER TR_PrecioAlterado_Producto
ON dbo.Producto FOR update
AS
declare @Precio_venta decimal(10)
select @Precio_venta = Valor from inserted
declare @id INT
select @id = id from inserted

declare @Proveedor_id int
select @Proveedor_id = (select Proveedor_id from Precio WHERE Producto_id=@id and Fecha_final IS NULL)
declare @Precio_compra decimal(10)
select @Precio_compra =(select Precio_compra from Precio WHERE Producto_id=@id and Fecha_final IS NULL)
--Proveedor_Producto where Proveedor_id=@Proveedor_id and Producto_id=@id)


update Precio set Fecha_final= DATEADD(ms,-3,dateadd(dd,DATEDIFF(dd,0,GETDATE()),0))
WHERE Producto_id=@id and Fecha_final IS NULL
if ((select Precio_compra from Proveedor_Producto where Producto_id=@id and Proveedor_id=@Proveedor_id)is not null)
BEGIN
insert into Precio VALUES(@id, @Proveedor_id, @Precio_venta, @Precio_compra ,dateadd(dd,DATEDIFF(dd,0,GETDATE()),0),Null) 
END
GO





--Inserts tablas pruebas
insert into Producto Values('Cerveza Edwin2',1500)
insert into Proveedor values('a','b','c','d','3')
insert into Proveedor_Producto VALUES(2,2,3000)



update Proveedor_Producto
set Precio_compra = 38000000
where Proveedor_id=1 and Producto_id=2

update Producto
set valor = 88888
where id=2



--truncate TABLE Proveedor_Producto
--truncate TABLE Precio








SELECT TOP (1000) [Proveedor_id]
    ,[Producto_id]
    ,[Precio_venta]
    ,[Precio_compra]
    ,[Fecha_inicio]
    ,[Fecha_final]
FROM [Bar2].[dbo].[Precio]


SELECT TOP (1000) [Proveedor_id]
    ,[Producto_id]
    ,[Precio_compra]
FROM [Bar2].[dbo].[Proveedor_Producto]

SELECT TOP (1000) [id]
    ,[nombre]
    ,[valor]
FROM [Bar2].[dbo].[Producto]