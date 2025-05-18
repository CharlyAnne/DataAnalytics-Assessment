/* Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
		--	Account tenure (months since signup)
		--	Total transactions
		--	Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
		--	Order by estimated CLV from highest to lowest */

SELECT u.id,
       CONCAT(u.first_name, ' ', u.last_name) AS name,                -- Concatenate first and last name since name col is NULL
       TIMESTAMPDIFF(MONTH, u.created_on, NOW()) AS tenure_months,    -- Get the tenure month of each account since its creation
       COUNT(ssa.id) AS total_transactions,                           -- Calculate total transactions done in the account
       ROUND(
        (COUNT(ssa.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.created_on, CURDATE()), 0)) 
        * 12 
        * AVG(ssa.confirmed_amount * 0.001), 2
        ) AS estimated_clv                                            -- clv = Customer Lifetime Value
FROM users_customuser AS u
JOIN 
    savings_savingsaccount AS ssa
ON 
    ssa.owner_id = u.id
WHERE ssa.confirmed_amount > 0
GROUP BY u.id, u.first_name, u.last_name, u.created_on
ORDER BY 
    estimated_clv DESC;
