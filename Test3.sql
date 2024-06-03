DECLARE @input NVARCHAR(MAX) = '1 -2 -3 4 5 -6f ss3 0 0 0 -0 0.0 0.05';

WITH SplitInput AS (
    SELECT value
    FROM STRING_SPLIT(@input, ' ')
),
FilteredNumbers AS (
    SELECT DISTINCT CAST(value AS INT) AS number
    FROM SplitInput
    WHERE ISNUMERIC(value) = 1 AND value NOT LIKE '%[^0-9-]%'
)
SELECT STRING_AGG(number, ' ') WITHIN GROUP (ORDER BY number) AS SortedNumbers
FROM FilteredNumbers;