
create table Client (
   noClient             int    Identity(1,1)              not null,
   nomClient            nvarchar(50)              null,
   prenomClient         nvarchar(50)             null,
   telClient            int                  null,
   mailClient           nvarchar (50)            null,
   constraint PK_CLIENT primary key nonclustered (noClient)
)