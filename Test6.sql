WITH RankedResults AS (
    SELECT
        Swimmer.FirstName,
        Swimmer.LastName,
        Competition.CompetitionName,
        Competition.StartDate,
        Competition.EndDate,
        Result.DeclaredTime,
        ROW_NUMBER() OVER (PARTITION BY Result.CompetitionID ORDER BY Result.DeclaredTime) AS Rank
    FROM
        Swimmer
    JOIN
        Result ON Swimmer.SwimmerID = Result.SwimmerID
    JOIN
        Competition ON Result.CompetitionID = Competition.CompetitionID
)
SELECT
    FirstName,
    LastName,
    CompetitionName,
    YEAR(StartDate) AS YarmComp,
    CASE Rank
        WHEN 1 THEN 'First'
        WHEN 2 THEN 'Second'
        WHEN 3 THEN 'Third'
    END AS WinnerComp,
    YEAR(StartDate) AS WinnerYear
FROM
    RankedResults
WHERE
    Rank <= 3
    AND (CompetitionName = 'Summer Olympic Games' OR YEAR(StartDate) = 2012);