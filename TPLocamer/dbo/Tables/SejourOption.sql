
create table SejourOption (
   noSupplement         int      identity(1,1)           not null,
   noSejour             int                  not null,
   quantite             int                  null,
   duree                int                  null,
primary key clustered (noSupplement, noSejour),
FOREIGN KEY (noSejour) REFERENCES [dbo].[Sejour] ([noSejour]) ON DELETE CASCADE,
FOREIGN KEY ([noSupplement]) REFERENCES [dbo].[Supplement] ([noSupplement]) ON DELETE CASCADE
)
