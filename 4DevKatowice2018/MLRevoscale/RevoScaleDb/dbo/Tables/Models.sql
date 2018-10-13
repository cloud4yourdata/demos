﻿CREATE TABLE [dbo].[Models]
(
	[Id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[ModelName] [VARCHAR](30) NOT NULL,
	[ModelLanguage] [VARCHAR](20) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[RMSE] FLOAT
)
