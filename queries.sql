-- CREATE DATABASE "DESTINATION";
-- GO
-- USE "DESTINATION";
-- GO

-- CREATE TABLE ACTOR (
--     "ACTORID" INTEGER PRIMARY KEY,
--     "FIRSTNAME" VARCHAR(100),
--     "SURNAME" VARCHAR(100),
--     "GENDER" VARCHAR(1),
--     "DATEOFBIRTH" DATE,
--     "BIRTHCOUNTRY" VARCHAR(50)
-- );

-- DROP TABLE IF EXISTS ERROR_EVENT;
-- GO

-- CREATE TABLE ERROR_EVENT (
--     "ERROR_ID" INT PRIMARY KEY IDENTITY(1,1),
--     "SOURCEDB" NVARCHAR(100) NOT NULL,
--     "SOURCETABLE" NVARCHAR(100) NOT NULL,
--     "SOURCEPKCOL" NVARCHAR(100) NOT NULL,
--     "SOURCEPK" NVARCHAR(100) NOT NULL,
--     "FILTERID" INT NOT NULL,
--     "ACTION" NVARCHAR(100) NOT NULL
-- );

-- CREATE TABLE COUNTRY_SPELLING (
--     "INVALID" NVARCHAR(100) NOT NULL,
--     "VALID" NVARCHAR(100) NOT NULL
-- )

-- INSERT INTO COUNTRY_SPELLING VALUES
--     ('UAS', 'USA'),
--     ('United States', 'USA'),
--     ('United States of America', 'USA'),
--     ('Unyted States', 'USA'),
--     ('United Staytes', 'USA'),
--     ('Aussie', 'Australia'),
--     ('Straya', 'Australia'),
--     ('OZ', 'Australia'),
--     ('Down Under', 'Australia'),
--     ('Kiwi Land', 'New Zealand');

-- 5
USE DESTINATION;
GO
EXEC master.dbo.sp_addlinkedserver
    @server = N'192.168.0.203, 1433',
    @srvproduct=N'SQL Server'
GO

EXEC master.dbo.sp_addlinkedsrvlogin   
    @rmtsrvname = N'192.168.0.203, 1433',      
    @useself = N'True',
    @locallogin = NULL;
GO

SELECT * FROM [192.168.0.203, 1433].ETL.dbo.ACTOR;

-- EXEC sp_dropserver '192.168.0.202, 1500', 'droplogins';

-- 6

SELECT * 
FROM [192.168.0.203, 1433].ETL.dbo.ACTOR
WHERE BIRTHCOUNTRY IN (SELECT CS.INVALID 
                      FROM COUNTRY_SPELLING CS
                      WHERE BIRTHCOUNTRY = INVALID)


-- 7
INSERT INTO ERROR_EVENT
(
    SOURCEDB,
    SOURCETABLE,
    SOURCEPKCOL,
    SOURCEPK,
    FILTERID,
    [ACTION]
)
SELECT
    'Source',
    'Actor',
    'ActorNO',
    ACTORNO,
    1,
    'MODIFY'
FROM [192.168.0.203, 1433].ETL.dbo.ACTOR
WHERE BIRTHCOUNTRY IN (SELECT CS.INVALID 
                      FROM COUNTRY_SPELLING CS
                      WHERE BIRTHCOUNTRY = INVALID)

SELECT * FROM ERROR_EVENT


-- 8
SELECT *
FROM [192.168.0.203, 1433].ETL.dbo.ACTOR
WHERE NOT EXISTS (SELECT *
                  FROM COUNTRY_SPELLING
                  WHERE BIRTHCOUNTRY = NULL 
                  OR BIRTHCOUNTRY = INVALID 
                  OR BIRTHCOUNTRY = VALID)


-- 9