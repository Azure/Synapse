SELECT
    [account].name, 
    FORMAT(SUM([opportunity].estimatedvalue), '$#,#') AS size_of_opportunities
FROM
    OPENROWSET(
        BULK 'https://mppc22lake.dfs.core.windows.net/datalake/bronze/d365/account.parquet',
        FORMAT = 'PARQUET'
    ) AS [account]
INNER JOIN     
    OPENROWSET(
        BULK 'https://mppc22lake.dfs.core.windows.net/datalake/bronze/d365/opportunity.parquet',
        FORMAT = 'PARQUET'
    ) AS [opportunity]
ON [account].accountid = [opportunity].parentaccountid
GROUP BY [account].name
ORDER BY SUM([opportunity].estimatedvalue) DESC