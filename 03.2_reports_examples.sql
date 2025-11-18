SELECT * FROM vw_MovieStats;
SELECT * FROM vw_MovieRankingByMinutes;
SELECT * FROM vw_UserSummary;

SELECT TOP 5 *
FROM dbo.vw_MovieStats
ORDER BY MinutesWatched DESC;

SELECT *
FROM dbo.vw_MovieRankingByMinutes
ORDER BY RankByMinutes ASC;

SELECT *
FROM vw_MovieStats
WHERE RatingCount >= 3
ORDER BY AvgRatings DESC;

SELECT TOP 3 * 
FROM vw_UserSummary
ORDER BY MinutesWatched DESC;

SELECT *
FROM dbo.vw_CountryStats
ORDER BY TotalMinutesWatched DESC;
