USE PlayFilm;
GO

-- 1) Plany
INSERT INTO dbo.Plans (PlanName, MonthlyPrice)
VALUES
    (N'Basic',    19.99),
    (N'Standard', 29.99),
    (N'Premium',  39.99);

-- 2) U¿ytkownicy
INSERT INTO dbo.Users (Email, FullName, Country, SignUpDate)
VALUES
    (N'anna.kowalska@example.com',  N'Anna Kowalska',   N'Poland',  '2024-01-05'),
    (N'jan.nowak@example.com',      N'Jan Nowak',       N'Poland',  '2024-02-10'),
    (N'marie.dupont@example.com',   N'Marie Dupont',    N'France',  '2024-03-15'),
    (N'peter.smith@example.com',    N'Peter Smith',     N'UK',      '2024-01-20'),
    (N'laura.muller@example.com',   N'Laura Müller',    N'Germany', '2024-04-01');

-- 3) Przypisanie planów
-- ID Planów: 1=Basic, 2=Standard, 3=Premium
INSERT INTO dbo.UserPlans (UserID, PlanID, StartDate, EndDate)
VALUES
    (1, 3, '2024-01-05', NULL), -- Anna, Premium
    (2, 2, '2024-02-10', NULL), -- Jan, Standard
    (3, 1, '2024-03-15', NULL), -- Marie, Basic
    (4, 2, '2024-01-20', '2024-09-01'), -- Peter, Standard zakoñczony
    (4, 3, '2024-09-02', NULL), -- Peter przeszed³ na Premium
    (5, 1, '2024-04-01', NULL); -- Laura, Basic

-- 4) Filmy
INSERT INTO dbo.Movies (Title, ReleaseYear, Genre, AgeRating)
VALUES
    (N'The Matrix',        1999, N'Sci-Fi',    N'16+'),
    (N'Inception',         2010, N'Sci-Fi',    N'13+'),
    (N'Toy Story',         1995, N'Animation', N'G'),
    (N'Interstellar',      2014, N'Sci-Fi',    N'13+'),
    (N'The Godfather',     1972, N'Crime',     N'18+'),
    (N'Frozen',            2013, N'Animation', N'G'),
    (N'Pulp Fiction',      1994, N'Crime',     N'18+'),
    (N'Spiderman',         2002, N'Action',    N'13+');

-- 5) Historia ogl¹dania (WatchHistory)
--  MovieID od 1 do 8, UserID od 1 do 5
INSERT INTO dbo.WatchHistory (UserID, MovieID, WatchedAt, MinutesWatched)
VALUES
    (1, 1, '2024-03-01T20:15:00', 120),
    (1, 2, '2024-03-05T21:00:00', 110),
    (1, 4, '2024-03-10T19:30:00', 130),
    (2, 3, '2024-03-02T18:00:00', 80),
    (2, 6, '2024-03-06T17:30:00', 95),
    (3, 1, '2024-03-07T21:15:00', 60),
    (3, 5, '2024-03-08T22:00:00', 175),
    (4, 2, '2024-03-03T20:00:00', 110),
    (4, 7, '2024-03-04T22:30:00', 150),
    (5, 3, '2024-03-09T16:45:00', 80),
    (5, 8, '2024-03-11T19:00:00', 100),
    (5, 1, '2024-03-12T20:00:00', 120);

-- 6) Oceny filmów
INSERT INTO dbo.Ratings (UserID, MovieID, Rating, RatedAt)
VALUES
    (1, 1, 9, '2024-03-02T20:00:00'),
    (1, 2, 8, '2024-03-06T21:30:00'),
    (1, 4, 10, '2024-03-11T20:00:00'),
    (2, 3, 7, '2024-03-02T19:00:00'),
    (2, 6, 8, '2024-03-07T18:00:00'),
    (3, 1, 8, '2024-03-08T21:30:00'),
    (3, 5, 9, '2024-03-09T23:30:00'),
    (4, 2, 9, '2024-03-03T21:30:00'),
    (4, 7, 8, '2024-03-05T23:30:00'),
    (5, 3, 8, '2024-03-09T17:30:00'),
    (5, 8, 7, '2024-03-11T20:30:00');


    