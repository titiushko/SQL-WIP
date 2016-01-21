USE PARCIAL3
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE MiExamenMG04077
(
    PERIODO  DATE NULL,
    NUMDOC   VARCHAR(10) NULL,
    CODBOD   CHAR(2) NULL,
    CORREL   VARCHAR(10) NULL,
    CODSAL   CHAR(1) NULL,
    DEPNUM   VARCHAR(4) NULL,
    CODVTA   CHAR(1) NULL,
    CODBAN   CHAR(2) NULL,
    CHEQUE   VARCHAR(10) NULL,
    ACUERDO  VARCHAR(10) NULL,
    FECENT   DATE NULL,
    ANULADO  BIT NULL,
    RECIBIDO VARCHAR(30) NULL,
    TOTALDOC NUMERIC(12,2) NULL,
    IMPRESO  BIT NULL,
    FECING   DATETIME NULL,
    CODUSER  VARCHAR(8) NULL
)