IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Datawarehouse')
BEGIN
	ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Datawarehouse;
END;

CREATE DATABASE Datawarehouse;

USE Datawarehouse;
CREATE SCHEMA Ekstraksi;
CREATE SCHEMA Transformasi;
CREATE SCHEMA Loading;