-- Query inactive savings accounts
-- Savings as sv
SELECT
    sv.id AS plan_id,
    sv.owner_id,
    'Savings' AS type,
    MAX(sv.created_on) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(sv.created_on)) AS inactivity_days
FROM savings_savingsaccount sv
 -- The savings must have actual funds
WHERE sv.confirmed_amount > 0
GROUP BY sv.id, sv.owner_id
-- Filter only savings inactive for over 1 year
HAVING DATEDIFF(CURDATE(), MAX(sv.created_on)) > 365 

UNION ALL 

-- Query inactive investment plans
-- Plans as pn
SELECT
    pn.id AS plan_id,
    pn.owner_id,
    'Investment' AS type,
    MAX(pn.created_on) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(pn.created_on)) AS inactivity_days
FROM plans_plan pn
-- The plan must have actual funds
WHERE pn.amount > 0   
GROUP BY pn.id, pn.owner_id
  -- Only consider plans inactive for over 1 year
HAVING DATEDIFF(CURDATE(), MAX(pn.created_on)) > 365;   
