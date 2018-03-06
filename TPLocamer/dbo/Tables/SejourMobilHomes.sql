
create table SejourMobilHomes (
   noMobilhomes         int                  not null,
   noSejour             int                  not null,
   constraint PK_ASSOCIATION4 primary key (noMobilhomes, noSejour),
   FOREIGN KEY (noSejour) REFERENCES [dbo].[Sejour] ([noSejour]) ON DELETE CASCADE,
   FOREIGN KEY (noMobilHomes) REFERENCES [dbo].[MobilHomes] ([noMobilHomes]) ON DELETE CASCADE,
)
