-- TODO: Replace <storage_name> with the name of your Primary ADLS Gen2 storage account name
-- and <container_name> with the name of the container chosen as the Primary ADLS Gen2 file system

CREATE DATABASE NYCTaxi;
GO

USE NYCTaxi;
GO

CREATE OR ALTER VIEW dbo.Trips
AS
SELECT
    *,
    [result].filepath(1) AS puYear,
    [result].filepath(2) AS puMonth
FROM
    OPENROWSET(
        BULK 'https://<storage_name>.dfs.core.windows.net/<container_name>/nycyellowtaxi/puYear=*/puMonth=*/*.parquet',
        FORMAT = 'PARQUET'
    ) AS [result];
GO

CREATE OR ALTER VIEW dbo.Weather
AS
SELECT
    *,
    [result].filepath(1) AS Year,
    [result].filepath(2) AS Month
FROM
    OPENROWSET(
        BULK 'https://<storage_name>.dfs.core.windows.net/<container_name>/isdweather/year=*/month=*/*.parquet',
        FORMAT = 'PARQUET'
    ) AS [result];