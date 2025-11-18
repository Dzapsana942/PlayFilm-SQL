IF DB_ID('PlayFilm') IS NULL
BEGIN

	CREATE DATABASE PlayFilm;
END;
GO

USE PlayFilm;
GO


CREATE TABLE dbo.Users (
	UserID INT IDENTITY(1,1) PRIMARY KEY,
	Email NVARCHAR(100) NOT NULL UNIQUE,
	FullName NVARCHAR(200) NOT NULL,
	Country NVARCHAR(200) NOT NULL,
	SingUpDate DATE NOT NULL DEFAULT (CAST(GETDATE() AS DATE))
);

CREATE TABLE dbo.Plans (
	PlanID INT IDENTITY(1,1) PRIMARY KEY,
	PlanName NVARCHAR(100) NOT NULL,
	MonthlyPrice DECIMAL(10,2) NOT NULL CHECK (MonthlyPrice >= 0)
);

CREATE TABLE dbo.UserPlans (
	UserPlanID INT IDENTITY(1,1) PRIMARY KEY,
	UserID INT NOT NULL,
	PlanID INT NOT NULL,
	StartDate DATE NOT NULL,
	EndDate DATE NULL,
	CONSTRAINT FK_UserPlans_Users FOREIGN KEY (UserID)
		REFERENCES dbo.Users(UserID),
	CONSTRAINT FK_UserPlans_Plans FOREIGN KEY (PlanID)
		REFERENCES dbo.Plans(PlanID)
);

CREATE TABLE dbo.Movies (
	MovieID INT IDENTITY(1,1) PRIMARY KEY,
	Title NVARCHAR(300) NOT NULL,
	ReleaseYear INT NOT NULL CHECK (ReleaseYear >= 1900),
	Genre NVARCHAR(200) NOT NULL,
	AgeRating NVARCHAR(10) NOT NULL
);

CREATE TABLE dbo.WatchHistory (
	WatchHistoryID INT IDENTITY(1,1) PRIMARY KEY,
	UserID INT NOT NULL,
	MovieID INT NOT NULL,
	WatchedAt DATETIME2 NOT NULL DEFAULT (SYSDATETIME()),
	MinutesWatched INT NOT NULL CHECK (MinutesWatched >=0),
	CONSTRAINT FK_WatchHistory_Users FOREIGN KEY (UserID)
		REFERENCES dbo.Users(UserID),
	CONSTRAINT FK_WatchHistory_Movies FOREIGN KEY (MovieID)
		REFERENCES dbo.Movies(MovieID)
);

CREATE TABLE dbo.Ratings (
	RatingID INT IDENTITY(1,1) PRIMARY KEY,
	UserID INT NOT NULL,
	MovieID INT NOT NULL,
	Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 10),
    RatedAt DATETIME2 NOT NULL DEFAULT (SYSDATETIME()),
    CONSTRAINT FK_Ratings_Users FOREIGN KEY (UserID)
        REFERENCES dbo.Users(UserID),
    CONSTRAINT FK_Ratings_Movies FOREIGN KEY (MovieID)
        REFERENCES dbo.Movies(MovieID),
    CONSTRAINT UQ_Ratings_User_Movie UNIQUE (UserID, MovieID) -- 1 ocena na film

);
