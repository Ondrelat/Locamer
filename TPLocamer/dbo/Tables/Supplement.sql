
create table Supplement (
   noSupplement         int   Identity(1,1)               not null,
   loue                 bit                  null,
   prix                 decimal                 null,
   libelle              nvarchar(50)              null,
primary key clustered (noSupplement)
)