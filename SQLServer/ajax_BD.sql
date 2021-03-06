IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'AJAX')
	DROP DATABASE [AJAX]
GO

CREATE DATABASE [AJAX]  ON (NAME = N'AJAX_Data', FILENAME = N'C:\Archivos de programa\Microsoft SQL Server\MSSQL\data\AJAX_Data.MDF' , SIZE = 1, FILEGROWTH = 10%) LOG ON (NAME = N'AJAX_Log', FILENAME = N'C:\Archivos de programa\Microsoft SQL Server\MSSQL\data\AJAX_Log.LDF' , SIZE = 1, FILEGROWTH = 10%)
 COLLATE Modern_Spanish_CI_AS
GO

exec sp_dboption N'AJAX', N'autoclose', N'true'
GO

exec sp_dboption N'AJAX', N'bulkcopy', N'false'
GO

exec sp_dboption N'AJAX', N'trunc. log', N'true'
GO

exec sp_dboption N'AJAX', N'torn page detection', N'true'
GO

exec sp_dboption N'AJAX', N'read only', N'false'
GO

exec sp_dboption N'AJAX', N'dbo use', N'false'
GO

exec sp_dboption N'AJAX', N'single', N'false'
GO

exec sp_dboption N'AJAX', N'autoshrink', N'true'
GO

exec sp_dboption N'AJAX', N'ANSI null default', N'false'
GO

exec sp_dboption N'AJAX', N'recursive triggers', N'false'
GO

exec sp_dboption N'AJAX', N'ANSI nulls', N'false'
GO

exec sp_dboption N'AJAX', N'concat null yields null', N'false'
GO

exec sp_dboption N'AJAX', N'cursor close on commit', N'false'
GO

exec sp_dboption N'AJAX', N'default to local cursor', N'false'
GO

exec sp_dboption N'AJAX', N'quoted identifier', N'false'
GO

exec sp_dboption N'AJAX', N'ANSI warnings', N'false'
GO

exec sp_dboption N'AJAX', N'auto create statistics', N'true'
GO

exec sp_dboption N'AJAX', N'auto update statistics', N'true'
GO

if( (@@microsoftversion / power(2, 24) = 8) and (@@microsoftversion & 0xffff >= 724) )
	exec sp_dboption N'AJAX', N'db chaining', N'false'
GO

use [AJAX]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Empresas_Giros_Comerciales]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Empresas] DROP CONSTRAINT FK_Empresas_Giros_Comerciales
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Empresas]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Empresas]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Giros_Comerciales]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Giros_Comerciales]
GO

CREATE TABLE [dbo].[Empresas] (
	[Id] [int] IDENTITY (1, 1) NOT NULL ,
	[Giro_Comercial_Id] [int] NOT NULL ,
	[Nombre] [nvarchar] (250) COLLATE Modern_Spanish_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Giros_Comerciales] (
	[Id] [int] IDENTITY (1, 1) NOT NULL ,
	[Descripcion] [nvarchar] (250) COLLATE Modern_Spanish_CI_AS NOT NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Empresas] WITH NOCHECK ADD 
	CONSTRAINT [PK_Empresas] PRIMARY KEY  CLUSTERED 
	(
		[Id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Giros_Comerciales] WITH NOCHECK ADD 
	CONSTRAINT [PK_giros_comerciales] PRIMARY KEY  CLUSTERED 
	(
		[Id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Empresas] ADD 
	CONSTRAINT [FK_Empresas_Giros_Comerciales] FOREIGN KEY 
	(
		[Giro_Comercial_Id]
	) REFERENCES [dbo].[Giros_Comerciales] (
		[Id]
	)
GO

