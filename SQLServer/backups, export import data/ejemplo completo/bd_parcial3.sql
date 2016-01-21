USE MASTER
GO
CREATE DATABASE PARCIAL3 ON  PRIMARY 
( NAME = N'PARCIAL3', FILENAME = N'E:\ArchivosDeProgramas\Microsoft SQL Server\MSSQL10_50.TITIUSHKO\MSSQL\DATA\PARCIAL3.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PARCIAL3_log', FILENAME = N'E:\ArchivosDeProgramas\Microsoft SQL Server\MSSQL10_50.TITIUSHKO\MSSQL\DATA\PARCIAL3_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE PARCIAL3 SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC PARCIAL3.sp_fulltext_database @action = 'enable'
END
GO
ALTER DATABASE PARCIAL3 SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE PARCIAL3 SET ANSI_NULLS OFF 
GO
ALTER DATABASE PARCIAL3 SET ANSI_PADDING OFF 
GO
ALTER DATABASE PARCIAL3 SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE PARCIAL3 SET ARITHABORT OFF 
GO
ALTER DATABASE PARCIAL3 SET AUTO_CLOSE OFF 
GO
ALTER DATABASE PARCIAL3 SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE PARCIAL3 SET AUTO_SHRINK OFF 
GO
ALTER DATABASE PARCIAL3 SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE PARCIAL3 SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE PARCIAL3 SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE PARCIAL3 SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE PARCIAL3 SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE PARCIAL3 SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE PARCIAL3 SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE PARCIAL3 SET  DISABLE_BROKER 
GO
ALTER DATABASE PARCIAL3 SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE PARCIAL3 SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE PARCIAL3 SET TRUSTWORTHY OFF 
GO
ALTER DATABASE PARCIAL3 SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE PARCIAL3 SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE PARCIAL3 SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE PARCIAL3 SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE PARCIAL3 SET  READ_WRITE 
GO
ALTER DATABASE PARCIAL3 SET RECOVERY FULL 
GO
ALTER DATABASE PARCIAL3 SET  MULTI_USER 
GO
ALTER DATABASE PARCIAL3 SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE PARCIAL3 SET DB_CHAINING OFF 
GO