/* Task: Calculate the avg number of transactions per customer per month and categorize them into frequency categories: 
   "High Frequency" (≥10 transactions/month)
   "Medium Frequency" (3-9 transactions/month)
   "Low Frequency" (≤2 transactions/month) */

WITH monthly_transaction AS (
    SELECT
        u.id,                
        -- Using CTE to get the count of each transaction done per month
        DATE_FORMAT(ssa.transaction_date, '%Y-%m'),
        COUNT(*) AS monthly_txn_count
    FROM users_customuser AS u
    INNER JOIN savings_savingsaccount AS ssa
        ON u.id = ssa.owner_id
    -- include only actual inflow transcations
    WHERE ssa.confirmed_amount > 0
    GROUP BY u.id, DATE_FORMAT(ssa.transaction_date, '%Y-%m')
),
-- Calculate the average transaction per customer per month
avg_txn_per_customer AS (
    SELECT
        id,
        AVG(monthly_txn_count) AS avg_transactions_per_month           
    FROM monthly_transaction
    GROUP BY id
)

-- frequency category
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 2) AS avg_transactions_per_month
FROM (
    SELECT
        id,
        avg_transactions_per_month,                                    
        CASE
            WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
            WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM avg_txn_per_customer
) AS categorized_customer
GROUP BY frequency_category
ORDER BY 
    CASE
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        ELSE 3
    END;
