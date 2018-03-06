
create table Coefficient (
   idCoefficient        int   Identity(1,1)               not null,
   libelle              varchar(50)                  null,
   coefficientReduction int                  null,
   constraint PK_COEFFICIENT primary key nonclustered (idCoefficient)
)