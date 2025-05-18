-- Query finds customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.
SELECT u.id AS owner_id,
  -- since name col is NULL, concatenate first name and Last name
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    COUNT(DISTINCT CASE WHEN pn.is_regular_savings = 1 THEN pn.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN pn.is_a_fund = 1 THEN pn.id END) AS investment_count,
    SUM(ssa.confirmed_amount) AS total_deposits
FROM 
    users_customuser u
JOIN 
    plans_plan pn ON u.id = pn.owner_id
JOIN 
    savings_savingsaccount ssa ON pn.id = ssa.plan_id
-- WHERE ssa.confirmed_amount >= 0
GROUP BY 
    u.id, u.name
HAVING 
    COUNT(DISTINCT CASE WHEN pn.is_regular_savings = 1 THEN pn.id END) >= 1
    AND
    COUNT(DISTINCT CASE WHEN pn.is_a_fund = 1 THEN pn.id END) >= 1
ORDER BY 
    total_deposits DESC;
