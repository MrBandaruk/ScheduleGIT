﻿/*
Deployment script for Database2

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Database2"
:setvar DefaultFilePrefix "Database2"
:setvar DefaultDataPath "C:\Users\Administrator\AppData\Local\Microsoft\VisualStudio\SSDT\Schedule"
:setvar DefaultLogPath "C:\Users\Administrator\AppData\Local\Microsoft\VisualStudio\SSDT\Schedule"

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
PRINT N'Creating [dbo].[FinalNews]...';


GO
CREATE TABLE [dbo].[FinalNews] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [ShortTitle]   NVARCHAR (60)  NOT NULL,
    [FullTitle]    NVARCHAR (256) NOT NULL,
    [ShortArticle] NVARCHAR (410) NOT NULL,
    [FullArticle]  NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [PK_FinalNews] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[FinalNewsImages]...';


GO
CREATE TABLE [dbo].[FinalNewsImages] (
    [Id]        INT             IDENTITY (1, 1) NOT NULL,
    [ImageItem] VARBINARY (MAX) NOT NULL,
    [NewsId]    INT             NOT NULL,
    CONSTRAINT [PK_FinalNewsImages] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[NewsOld]...';


GO
CREATE TABLE [dbo].[NewsOld] (
    [Id]    INT            IDENTITY (1, 1) NOT NULL,
    [Title] NVARCHAR (256) NOT NULL,
    [Body]  NVARCHAR (500) NOT NULL,
    CONSTRAINT [PK_News1] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[NewsV]...';


GO
CREATE TABLE [dbo].[NewsV] (
    [Id]    INT            IDENTITY (1, 1) NOT NULL,
    [Title] NVARCHAR (60)  NOT NULL,
    [Body]  NVARCHAR (410) NOT NULL,
    CONSTRAINT [PK_NewsV1] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[FK_FinalNewsImages_FinalNews]...';


GO
ALTER TABLE [dbo].[FinalNewsImages] WITH NOCHECK
    ADD CONSTRAINT [FK_FinalNewsImages_FinalNews] FOREIGN KEY ([NewsId]) REFERENCES [dbo].[FinalNews] ([Id]);


GO
PRINT N'Creating [dbo].[FK_NewsImage_NewsV]...';


GO
ALTER TABLE [dbo].[NewsImage] WITH NOCHECK
    ADD CONSTRAINT [FK_NewsImage_NewsV] FOREIGN KEY ([NewsId]) REFERENCES [dbo].[NewsV] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[FinalNewsImages] WITH CHECK CHECK CONSTRAINT [FK_FinalNewsImages_FinalNews];

ALTER TABLE [dbo].[NewsImage] WITH CHECK CHECK CONSTRAINT [FK_NewsImage_NewsV];


GO
PRINT N'Update complete.';


GO