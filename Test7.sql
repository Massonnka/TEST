WITH RankedResults AS (
    SELECT
        r.CompetitionId,
        r.SwimmerId,
        r.DeclaredTime,
        ROW_NUMBER() OVER (PARTITION BY r.CompetitionId ORDER BY r.DeclaredTime) AS Place
    FROM
        Result r
),
CoachScores AS (
    SELECT
        bsc.CoachId,
        SUM(
            CASE 
                WHEN rr.Place = 1 THEN 3
                WHEN rr.Place = 2 THEN 2
                WHEN rr.Place = 3 THEN 1
                ELSE 0
            END
        ) AS RatingSum
    FROM
        RankedResults rr
        INNER JOIN BridgeSwimmerCoach bsc ON rr.SwimmerId = bsc.SwimmerId
    GROUP BY
        bsc.CoachId
)
SELECT TOP 30
    c.CoachId,
    CONCAT(c.FirstName, ' ', c.LastName) AS Coach,
    cs.RatingSum
FROM
    CoachScores cs
    INNER JOIN Coach c ON cs.CoachId = c.CoachId
ORDER BY
    cs.RatingSum DESC;