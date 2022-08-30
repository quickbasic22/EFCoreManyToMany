-- Script Date: 8/30/2022 1:31 PM  - ErikEJ.SqlCeScripting version 3.5.2.94
-- Database information:
-- Database: C:\Users\quick\source\repos\EFCoreManyToMany\EFCoreManyToMany\bin\Debug\net6.0\Movies.db
-- ServerVersion: 3.38.5.1
-- DatabaseSize: 28 KB
-- Created: 8/30/2022 12:14 PM

-- User Table information:
-- Number of tables: 3
-- GenreMovie: -1 row(s)
-- Genres: -1 row(s)
-- movies: -1 row(s)

SELECT 1;
PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE [movies] (
  [Id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Title] text NOT NULL
);
CREATE TABLE [Genres] (
  [Id] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Name] text NOT NULL
);
CREATE TABLE [GenreMovie] (
  [GenresId] INTEGER NOT NULL
, [MoviesId] INTEGER NOT NULL
, CONSTRAINT [sqlite_autoindex_GenreMovie_1] PRIMARY KEY ([GenresId],[MoviesId])
, CONSTRAINT [FK_GenreMovie_0_0] FOREIGN KEY ([MoviesId]) REFERENCES [movies] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
, CONSTRAINT [FK_GenreMovie_1_0] FOREIGN KEY ([GenresId]) REFERENCES [Genres] ([Id]) ON DELETE CASCADE ON UPDATE NO ACTION
);
INSERT INTO [movies] ([Id],[Title]) VALUES (
1,'Avengers');
INSERT INTO [movies] ([Id],[Title]) VALUES (
2,'Spiderman: Spiderverse');
INSERT INTO [movies] ([Id],[Title]) VALUES (
3,'Inception');
INSERT INTO [Genres] ([Id],[Name]) VALUES (
1,'Drama');
INSERT INTO [Genres] ([Id],[Name]) VALUES (
2,'Action');
INSERT INTO [Genres] ([Id],[Name]) VALUES (
3,'Animation');
INSERT INTO [GenreMovie] ([GenresId],[MoviesId]) VALUES (
1,3);
INSERT INTO [GenreMovie] ([GenresId],[MoviesId]) VALUES (
2,1);
INSERT INTO [GenreMovie] ([GenresId],[MoviesId]) VALUES (
2,2);
INSERT INTO [GenreMovie] ([GenresId],[MoviesId]) VALUES (
3,2);
CREATE INDEX [GenreMovie_IX_GenreMovie_MoviesId] ON [GenreMovie] ([MoviesId] ASC);
CREATE TRIGGER [fki_GenreMovie_MoviesId_movies_Id] BEFORE Insert ON [GenreMovie] FOR EACH ROW BEGIN SELECT RAISE(ROLLBACK, 'Insert on table GenreMovie violates foreign key constraint FK_GenreMovie_0_0') WHERE (SELECT Id FROM movies WHERE  Id = NEW.MoviesId) IS NULL; END;
CREATE TRIGGER [fku_GenreMovie_MoviesId_movies_Id] BEFORE Update ON [GenreMovie] FOR EACH ROW BEGIN SELECT RAISE(ROLLBACK, 'Update on table GenreMovie violates foreign key constraint FK_GenreMovie_0_0') WHERE (SELECT Id FROM movies WHERE  Id = NEW.MoviesId) IS NULL; END;
CREATE TRIGGER [fki_GenreMovie_GenresId_Genres_Id] BEFORE Insert ON [GenreMovie] FOR EACH ROW BEGIN SELECT RAISE(ROLLBACK, 'Insert on table GenreMovie violates foreign key constraint FK_GenreMovie_1_0') WHERE (SELECT Id FROM Genres WHERE  Id = NEW.GenresId) IS NULL; END;
CREATE TRIGGER [fku_GenreMovie_GenresId_Genres_Id] BEFORE Update ON [GenreMovie] FOR EACH ROW BEGIN SELECT RAISE(ROLLBACK, 'Update on table GenreMovie violates foreign key constraint FK_GenreMovie_1_0') WHERE (SELECT Id FROM Genres WHERE  Id = NEW.GenresId) IS NULL; END;
COMMIT;

