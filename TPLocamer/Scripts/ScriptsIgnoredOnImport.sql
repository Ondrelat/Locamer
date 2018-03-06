
/*==============================================================*/
/* Nom de SGBD :  Microsoft SQL Server 2005                     */
/* Date de création :  06/02/2018 17:00:55                      */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MobilHomes') and o.name = 'FK_MOBILHOM_ASSOCIATI_TARIF')
alter table MobilHomes
   drop constraint FK_MOBILHOM_ASSOCIATI_TARIF
GO

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Sejour') and o.name = 'FK_SEJOUR_ASSOCIATI_CLIENT')
alter table Sejour
   drop constraint FK_SEJOUR_ASSOCIATI_CLIENT
GO

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Sejour') and o.name = 'FK_SEJOUR_ASSOCIATI_COEFFICI')
alter table Sejour
   drop constraint FK_SEJOUR_ASSOCIATI_COEFFICI
GO

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SejourOption') and o.name = 'FK_SEJOUROP_ASSOCIATI_SEJOUR')
alter table SejourOption
   drop constraint FK_SEJOUROP_ASSOCIATI_SEJOUR
GO

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SejourOption') and o.name = 'FK_SEJOUROP_ASSOCIATI_SUPPLEME')
alter table SejourOption
   drop constraint FK_SEJOUROP_ASSOCIATI_SUPPLEME
GO

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('association4') and o.name = 'FK_ASSOCIAT_ASSOCIATI_MOBILHOM')
alter table association4
   drop constraint FK_ASSOCIAT_ASSOCIATI_MOBILHOM
GO

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('association4') and o.name = 'FK_ASSOCIAT_ASSOCIATI_SEJOUR')
alter table association4
   drop constraint FK_ASSOCIAT_ASSOCIATI_SEJOUR
GO

if exists (select 1
            from  sysobjects
           where  id = object_id('Client')
            and   type = 'U')
   drop table Client
GO

if exists (select 1
            from  sysobjects
           where  id = object_id('Coefficient')
            and   type = 'U')
   drop table Coefficient
GO

if exists (select 1
            from  sysindexes
           where  id    = object_id('MobilHomes')
            and   name  = 'ASSOCIATION6_FK'
            and   indid > 0
            and   indid < 255)
   drop index MobilHomes.ASSOCIATION6_FK
GO

if exists (select 1
            from  sysobjects
           where  id = object_id('MobilHomes')
            and   type = 'U')
   drop table MobilHomes
GO

if exists (select 1
            from  sysindexes
           where  id    = object_id('Sejour')
            and   name  = 'ASSOCIATION7_FK'
            and   indid > 0
            and   indid < 255)
   drop index Sejour.ASSOCIATION7_FK
GO

if exists (select 1
            from  sysindexes
           where  id    = object_id('Sejour')
            and   name  = 'ASSOCIATION1_FK'
            and   indid > 0
            and   indid < 255)
   drop index Sejour.ASSOCIATION1_FK
GO

if exists (select 1
            from  sysobjects
           where  id = object_id('Sejour')
            and   type = 'U')
   drop table Sejour
GO

if exists (select 1
            from  sysindexes
           where  id    = object_id('SejourOption')
            and   name  = 'ASSOCIATION5_FK2'
            and   indid > 0
            and   indid < 255)
   drop index SejourOption.ASSOCIATION5_FK2
GO

if exists (select 1
            from  sysindexes
           where  id    = object_id('SejourOption')
            and   name  = 'ASSOCIATION5_FK'
            and   indid > 0
            and   indid < 255)
   drop index SejourOption.ASSOCIATION5_FK
GO

if exists (select 1
            from  sysobjects
           where  id = object_id('SejourOption')
            and   type = 'U')
   drop table SejourOption
GO

if exists (select 1
            from  sysobjects
           where  id = object_id('Supplement')
            and   type = 'U')
   drop table Supplement
GO

if exists (select 1
            from  sysobjects
           where  id = object_id('Tarif')
            and   type = 'U')
   drop table Tarif
GO

if exists (select 1
            from  sysindexes
           where  id    = object_id('association4')
            and   name  = 'ASSOCIATION4_FK2'
            and   indid > 0
            and   indid < 255)
   drop index association4.ASSOCIATION4_FK2
GO

if exists (select 1
            from  sysindexes
           where  id    = object_id('association4')
            and   name  = 'ASSOCIATION4_FK'
            and   indid > 0
            and   indid < 255)
   drop index association4.ASSOCIATION4_FK
GO

if exists (select 1
            from  sysobjects
           where  id = object_id('association4')
            and   type = 'U')
   drop table association4
GO
