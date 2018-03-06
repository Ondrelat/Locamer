create table Tarif (
   noTarif              int  Identity(1,1)                not null,
   libelleTarif         nvarchar(50)              null,
   prix                 decimal(3,2)                  null,
   primary key clustered (noTarif)
)