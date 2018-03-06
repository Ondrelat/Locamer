
create table MobilHomes (
   noMobilhomes         int                  not null,
   noTarif              int                  not null,
   numEmplacement       int                  null,
   capacite             nvarchar(50)             null,
   terrasseCouverte     bit                  null,
   constraint PK_MOBILHOMES primary key nonclustered (noMobilhomes)
)
