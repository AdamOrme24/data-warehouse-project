/*
=============================================================
Creation of Database and Schemas
=============================================================
Script Purpose:
    This script checks if a database named 'Datwarehouse' exists, and if not, it creates a new database with that name.
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
CAUTIONS:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the existing 'DataWarehouse' database will be permanently deleted if exists.
    Take care with whitespaces adn spelling errors when checking if 'DataWarehouse' exists - name should be in CamelType.
    Ensure you have proper backups before running this script.
*/

USE master;
GO

-- Query to drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Query to create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Query to create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
