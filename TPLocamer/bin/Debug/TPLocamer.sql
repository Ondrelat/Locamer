/*
Script de déploiement pour TPLocamer

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "TPLocamer"
:setvar DefaultFilePrefix "TPLocamer"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Détectez le mode SQLCMD et désactivez l'exécution du script si le mode SQLCMD n'est pas pris en charge.
Pour réactiver le script une fois le mode SQLCMD activé, exécutez ce qui suit :
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Création de $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Création de [dbo].[Client]...';


GO
CREATE TABLE [dbo].[Client] (
    [noClient]     INT           IDENTITY (1, 1) NOT NULL,
    [nomClient]    NVARCHAR (50) NULL,
    [prenomClient] NVARCHAR (50) NULL,
    [telClient]    INT           NULL,
    [mailClient]   NVARCHAR (50) NULL,
    CONSTRAINT [PK_CLIENT] PRIMARY KEY NONCLUSTERED ([noClient] ASC)
);


GO
PRINT N'Création de [dbo].[Coefficient]...';


GO
CREATE TABLE [dbo].[Coefficient] (
    [idCoefficient]        INT          IDENTITY (1, 1) NOT NULL,
    [libelle]              VARCHAR (50) NULL,
    [coefficientReduction] INT          NULL,
    CONSTRAINT [PK_COEFFICIENT] PRIMARY KEY NONCLUSTERED ([idCoefficient] ASC)
);


GO
PRINT N'Création de [dbo].[MobilHomes]...';


GO
CREATE TABLE [dbo].[MobilHomes] (
    [noMobilhomes]     INT           NOT NULL,
    [noTarif]          INT           NOT NULL,
    [numEmplacement]   INT           NULL,
    [capacite]         NVARCHAR (50) NULL,
    [terrasseCouverte] BIT           NULL,
    CONSTRAINT [PK_MOBILHOMES] PRIMARY KEY NONCLUSTERED ([noMobilhomes] ASC)
);


GO
PRINT N'Création de [dbo].[Sejour]...';


GO
CREATE TABLE [dbo].[Sejour] (
    [noSejour]      INT  IDENTITY (1, 1) NOT NULL,
    [idCoefficient] INT  NOT NULL,
    [noClient]      INT  NOT NULL,
    [dateArrivee]   DATE NULL,
    [dateFin]       DATE NULL,
    CONSTRAINT [PK_SEJOUR] PRIMARY KEY NONCLUSTERED ([noSejour] ASC)
);


GO
PRINT N'Création de [dbo].[Sejour].[ASSOCIATION1_FK]...';


GO
CREATE NONCLUSTERED INDEX [ASSOCIATION1_FK]
    ON [dbo].[Sejour]([noClient] ASC);


GO
PRINT N'Création de [dbo].[Sejour].[ASSOCIATION7_FK]...';


GO
CREATE NONCLUSTERED INDEX [ASSOCIATION7_FK]
    ON [dbo].[Sejour]([idCoefficient] ASC);


GO
PRINT N'Création de [dbo].[SejourMobilHomes]...';


GO
CREATE TABLE [dbo].[SejourMobilHomes] (
    [noMobilhomes] INT NOT NULL,
    [noSejour]     INT NOT NULL,
    CONSTRAINT [PK_ASSOCIATION4] PRIMARY KEY CLUSTERED ([noMobilhomes] ASC, [noSejour] ASC)
);


GO
PRINT N'Création de [dbo].[SejourOption]...';


GO
CREATE TABLE [dbo].[SejourOption] (
    [noSupplement] INT NOT NULL,
    [noSejour]     INT NOT NULL,
    [quantite]     INT NULL,
    [duree]        INT NULL,
    PRIMARY KEY CLUSTERED ([noSupplement] ASC, [noSejour] ASC)
);


GO
PRINT N'Création de [dbo].[Supplement]...';


GO
CREATE TABLE [dbo].[Supplement] (
    [noSupplement] INT           IDENTITY (1, 1) NOT NULL,
    [loue]         BIT           NULL,
    [prix]         DECIMAL (18)  NULL,
    [libelle]      NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([noSupplement] ASC)
);


GO
PRINT N'Création de [dbo].[Tarif]...';


GO
CREATE TABLE [dbo].[Tarif] (
    [noTarif]      INT            IDENTITY (1, 1) NOT NULL,
    [libelleTarif] NVARCHAR (50)  NULL,
    [prix]         DECIMAL (3, 2) NULL,
    PRIMARY KEY CLUSTERED ([noTarif] ASC)
);


GO
PRINT N'Création de [dbo].[FK_SEJOUR_ASSOCIATI_CLIENT]...';


GO
ALTER TABLE [dbo].[Sejour]
    ADD CONSTRAINT [FK_SEJOUR_ASSOCIATI_CLIENT] FOREIGN KEY ([noClient]) REFERENCES [dbo].[Client] ([noClient]);


GO
PRINT N'Création de [dbo].[FK_SEJOUR_ASSOCIATI_COEFFICI]...';


GO
ALTER TABLE [dbo].[Sejour]
    ADD CONSTRAINT [FK_SEJOUR_ASSOCIATI_COEFFICI] FOREIGN KEY ([idCoefficient]) REFERENCES [dbo].[Coefficient] ([idCoefficient]);


GO
PRINT N'Création de contrainte sans nom sur [dbo].[SejourMobilHomes]...';


GO
ALTER TABLE [dbo].[SejourMobilHomes]
    ADD FOREIGN KEY ([noSejour]) REFERENCES [dbo].[Sejour] ([noSejour]) ON DELETE CASCADE;


GO
PRINT N'Création de contrainte sans nom sur [dbo].[SejourMobilHomes]...';


GO
ALTER TABLE [dbo].[SejourMobilHomes]
    ADD FOREIGN KEY ([noMobilhomes]) REFERENCES [dbo].[MobilHomes] ([noMobilhomes]) ON DELETE CASCADE;


GO
PRINT N'Création de contrainte sans nom sur [dbo].[SejourOption]...';


GO
ALTER TABLE [dbo].[SejourOption]
    ADD FOREIGN KEY ([noSejour]) REFERENCES [dbo].[Sejour] ([noSejour]) ON DELETE CASCADE;


GO
PRINT N'Création de contrainte sans nom sur [dbo].[SejourOption]...';


GO
ALTER TABLE [dbo].[SejourOption]
    ADD FOREIGN KEY ([noSupplement]) REFERENCES [dbo].[Supplement] ([noSupplement]) ON DELETE CASCADE;


GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Mise à jour terminée.';


GO
