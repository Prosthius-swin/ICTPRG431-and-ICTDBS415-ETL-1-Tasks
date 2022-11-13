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

CREATE TABLE ERROR_EVENT (
    "ERROR_ID" INT PRIMARY KEY,
    "SOURCEDB" NVARCHAR(100) NOT NULL,
    "SOURCETABLE" NVARCHAR(100) NOT NULL,
    "SOURCEPKCOL" NVARCHAR(100) NOT NULL,
    "SOURCEPK" NVARCHAR(100) NOT NULL,
    "FILTERID" INT NOT NULL,
    "ACTION" NVARCHAR(100) NOT NULL
);

CREATE TABLE COUNTRY_SPELLING (
    "INVALID" NVARCHAR(100) NOT NULL,
    "VALID" NVARCHAR(100) NOT NULL
)

INSERT INTO COUNTRY_SPELLING VALUES
    ('UAS', 'USA'),
    ('United States', 'USA'),
    ('United States of America', 'USA'),
    ('Unyted States', 'USA'),
    ('United Staytes', 'USA'),
    ('Aussie', 'Australia'),
    ('Straya', 'Australia'),
    ('OZ', 'Australia'),
    ('Down Under', 'Australia'),
    ('Kiwi Land', 'New Zealand');
