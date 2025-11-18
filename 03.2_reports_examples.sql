USE PlayFilm;
GO

-- Podgląd wszystkich widoków
SELECT * FROM dbo.vw_MovieStats;
SELECT * FROM dbo.vw_MovieRankingByMinutes;
SELECT * FROM dbo.vw_UserSummary;

-- Top 5 najdłużej oglądanych filmów
SELECT TOP 5 *
FROM dbo.vw_MovieStats
ORDER BY MinutesWatched DESC, Title;

-- Pełny ranking filmów wg minut oglądania
SELECT *
FROM dbo.vw_MovieRankingByMinutes
ORDER BY RankByMinutes ASC, Title;

-- Filmy z co najmniej 3 ocenami, posortowane po średniej ocen
SELECT *
FROM dbo.vw_MovieStats
WHERE RatingCount >= 3
ORDER BY AvgRatings DESC, RatingCount DESC, Title;

-- Top 3 najbardziej aktywnych użytkowników
SELECT TOP 3 * 
FROM dbo.vw_UserSummary
ORDER BY MinutesWatched DESC, FullName;

-- Statystyki krajów wg łącznego czasu oglądania
SELECT *
FROM dbo.vw_CountryStats
ORDER BY TotalMinutesWatched DESC, Country;
