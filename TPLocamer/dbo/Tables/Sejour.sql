/*==============================================================*/
/* Table : Sejour                                               */
/*==============================================================*/
create table Sejour (
   noSejour             int      Identity(1,1)            not null,
   idCoefficient        int                  not null,
   noClient             int                  not null,
   dateArrivee          date                  null,
   dateFin              date                 null,
   constraint PK_SEJOUR primary key nonclustered (noSejour)
)
GO
alter table Sejour
   add constraint FK_SEJOUR_ASSOCIATI_CLIENT foreign key (noClient)
      references Client (noClient)
GO
alter table Sejour
   add constraint FK_SEJOUR_ASSOCIATI_COEFFICI foreign key (idCoefficient)
      references Coefficient (idCoefficient)
GO
create index ASSOCIATION1_FK on Sejour (
noClient ASC
)
GO
create index ASSOCIATION7_FK on Sejour (
idCoefficient ASC
)