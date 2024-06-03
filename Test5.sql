WITH RankedResults AS (
    SELECT
        r.DeclaredTime,
        r.Distanse,
        r.Style,
        r.SwimmerID,
        r.CompetitionID,
        c.CoachID,
        c.FirstName,
        c.LastName,
        r.DeclaredTime AS Result,
        CONCAT(c.FirstName, ' ', c.LastName) AS Coach,
        DENSE_RANK() OVER (ORDER BY r.DeclaredTime ASC) AS Rank,
        ROW_NUMBER() OVER (PARTITION BY r.SwimmerID, r.CompetitionID ORDER BY r.DeclaredTime ASC) AS RowNum
    FROM
        Result r
    JOIN
        Swimmer sw ON r.SwimmerID = sw.SwimmerID
    JOIN
        BridgeSwimmerCoach bsc ON sw.SwimmerID = bsc.SwimmerID
    JOIN
        Coach c ON bsc.CoachID = c.CoachID
)
SELECT
    DeclaredTime,
    Distanse,
    Style,
    SwimmerID,
    CompetitionID,
    CoachID,
    FirstName,
    LastName,
    Result,
    Coach,
    Rank
FROM
    RankedResults
WHERE
    RowNum = 1
ORDER BY
    DeclaredTime ASC;