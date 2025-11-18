USE PlayFilm;
GO

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'playfilm_reader')
BEGIN
	CREATE LOGIN playfilm_reader
		WITH PASSWORD = 'reader123!', CHECK_POLICY = ON;
END;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'playfilm_reader')
BEGIN
	CREATE USER playfilm_reader FOR LOGIN playfilm_reader;
END;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'report_reader')
BEGIN 
	CREATE ROLE report_reader;
END;
GO

ALTER ROLE report_reader ADD MEMBER playfilm_reader;
GO

GRANT SELECT ON dbo.vw_UserSummary TO report_reader;
GRANT SELECT ON dbo.vw_MovieRankingByMinutes TO report_reader;
GRANT SELECT ON dbo.vw_MovieStats TO report_reader;

DENY SELECT, INSERT, UPDATE, DELETE ON dbo.Users TO report_reader;
DENY SELECT, INSERT, UPDATE, DELETE ON dbo.Plans TO report_reader;
DENY SELECT, INSERT, UPDATE, DELETE ON dbo.UserPlans TO report_reader;
DENY SELECT, INSERT, UPDATE, DELETE ON dbo.Movies TO report_reader;
DENY SELECT, INSERT, UPDATE, DELETE ON dbo.WatchHistory TO report_reader;
DENY SELECT, INSERT, UPDATE, DELETE ON dbo.Ratings TO report_reader;

EXECUTE AS USER = 'playfilm_reader';