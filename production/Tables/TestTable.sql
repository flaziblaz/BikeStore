﻿CREATE TABLE [dbo].[TestTable]
(
	[Id] INT NOT NULL PRIMARY KEY identity(1,1), 
    [Testcol] VARCHAR(50) NOT NULL, 
    [Testcol2] NCHAR(10) NULL, 
    [Testcol3] NCHAR(10) NULL, 
    [Testcol4] NCHAR(10) NULL, 
    [Testcol5] NCHAR(10) NULL
)
