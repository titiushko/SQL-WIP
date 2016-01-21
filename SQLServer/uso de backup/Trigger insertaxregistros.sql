USE [PARCIAL3]
GO

/****** Object:  Trigger [dbo].[TR_INSERTAXREGISTROS]    Script Date: 01/20/2012 14:28:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[TR_INSERTAXREGISTROS] 
   ON  [dbo].[MiExamenGC06016]
   FOR INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    EXEC GENERAXREGISTROS

END

GO

