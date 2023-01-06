CREATE TABLE [dbo].[Warehouse]
(
	[Id] INT identity(1,1) NOT NULL PRIMARY KEY, 
    [WarehouseName] VARCHAR(50) NOT NULL, 
    [WarehouseDescription] VARCHAR(100) NULL,
    [Test] NCHAR(10) NULL, 
    constraint uc_warehousename unique (WarehouseName)
)
