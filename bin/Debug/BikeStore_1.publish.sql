﻿/*
Deployment script for BikeStore

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BikeStore"
:setvar DefaultFilePrefix "BikeStore"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Starting rebuilding table [dbo].[Warehouse]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Warehouse] (
    [Id]                   INT           IDENTITY (1, 1) NOT NULL,
    [WarehouseName]        VARCHAR (50)  NOT NULL,
    [WarehouseDescription] VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [tmp_ms_xx_constraint_uc_warehousename1] UNIQUE NONCLUSTERED ([WarehouseName] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Warehouse])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Warehouse] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Warehouse] ([Id], [WarehouseName], [WarehouseDescription])
        SELECT   [Id],
                 [WarehouseName],
                 [WarehouseDescription]
        FROM     [dbo].[Warehouse]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Warehouse] OFF;
    END

DROP TABLE [dbo].[Warehouse];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Warehouse]', N'Warehouse';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_uc_warehousename1]', N'uc_warehousename', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
insert into warehouse (WarehouseName,WarehouseDescription)
values ('Main','Main Warehouse')
GO

GO
PRINT N'Update complete.';


GO
