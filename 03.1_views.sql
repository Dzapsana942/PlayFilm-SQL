USE PlayFilm;
GO


--Widok: podsumowanie u¿ytkownika
CREATE OR ALTER VIEW dbo.vw_UserSummary AS
WITH WhAgg AS (
    SELECT
        UserID,
        COUNT(DISTINCT MovieID)   AS MoviesWatched,
        COUNT(*)                  AS WatchSession,
        SUM(MinutesWatched)       AS MinutesWatched
    FROM dbo.WatchHistory
    GROUP BY UserID
),
RAgg AS (
    SELECT
        UserID,
        AVG(CAST(Rating AS DECIMAL(4,2))) AS AvgRating
    FROM dbo.Ratings
    GROUP BY UserID
)
SELECT
    u.UserID,
    u.FullName,
    u.Country,
    COALESCE(w.MoviesWatched, 0)   AS MoviesWatched,
    COALESCE(w.WatchSession, 0)    AS WatchSession,
    COALESCE(w.MinutesWatched, 0)  AS MinutesWatched,
    r.AvgRating                    AS AvgRating
FROM dbo.Users u
LEFT JOIN WhAgg w ON w.UserID = u.UserID
LEFT JOIN RAgg r ON r.UserID = u.UserID;

	

--Widok: statystyki filmu
CREATE OR ALTER VIEW dbo.vw_MovieStats AS
WITH WhAgg AS (
    SELECT
        MovieID,
        COUNT(*)            AS WatchCount,
        SUM(MinutesWatched) AS MinutesWatched
    FROM dbo.WatchHistory
    GROUP BY MovieID
),
RAgg AS (
    SELECT
        MovieID,
        COUNT(*)                               AS RatingCount,
        AVG(CAST(Rating AS DECIMAL(4,2)))      AS AvgRatings
    FROM dbo.Ratings
    GROUP BY MovieID
)
SELECT
    m.MovieID,
    m.Title,
    m.ReleaseYear,
    m.Genre,
    m.AgeRating,
    COALESCE(w.MinutesWatched, 0) AS MinutesWatched,
    COALESCE(w.WatchCount, 0)     AS WatchCount,
    COALESCE(r.RatingCount, 0)    AS RatingCount,
    r.AvgRatings
FROM dbo.Movies m
LEFT JOIN WhAgg w ON w.MovieID = m.MovieID
LEFT JOIN RAgg r ON r.MovieID = m.MovieID;



--Widok: ranking filmów wed³ug czasu ogl¹dania
CREATE OR ALTER VIEW dbo.vw_MovieRankingByMinutes AS
SELECT
	ms.*,
	RANK() OVER (ORDER BY ms.MinutesWatched DESC) AS RankByMinutes
FROM dbo.vw_MovieStats ms;



--Widok: Statystyki ogl¹dalnoœci filmów wed³ug krajów
CREATE OR ALTER VIEW dbo.vw_CountryStats AS
SELECT 
	Country,
	COUNT(*)              AS UsersCount,
	SUM(MoviesWatched)    AS TotalMoviesWatched,
	SUM(MinutesWatched)   AS TotalMinutesWatched
FROM dbo.vw_UserSummary
GROUP BY Country;

