# Data Analytics Assessment

## Repo Overview
This repository contains my solutions to the Cowrywise SQL-based Data Analyst assessment. The tasks involved querying a relational database to uncover customer insights, improve analytical thinking and support business decisions across savings and investment products.

---

### Q1: High-Value Customers with Multiple Products
**Objective: Identify customers who have both a funded savings plan and a funded investment plan.**

**Approach:**
- Joined `users_customuser`, `savings_savingsaccount`, and `plans_plan` using the foreign key.
- I constructed `name` by concatenating `first_name` and `last_name`. 
- Filtered for users who had atleast one savings plan `is_regular_savings = 1` and at least one investment plan `is_a_fund = 1` with actual inflow `confirmed_amount > 0`.
- Then aggregated their total deposits and sorted them in descending order to identify the highest-value customers across both product types

**Challenges:**
- The `name` field in the users table was null. I resolved this by concatenating `first_name` and `last_name` to create a usable full name for display purposes.
- Understanding the difference between savings and investment plans required careful interpretation of the `is_regular_savings` and `is_a_fund flags`. I made sure to count plans based on the correct flag combinations for accurate customer classification.

---

### Q2: Transaction Frequency Analysis
**Objective: Calculate the average number of transactions per customer per month and categorize them:**
- "High Frequency" (≥10 transactions/month)
- "Medium Frequency" (3-9 transactions/month)
- "Low Frequency" (≤2 transactions/month)**

**Approach:**
- Calculated the average number of transactions per customer per month using a two-step CTE process.
- The first CTE aggregated monthly transactions, and the second computed the average transaction count per customer.
- Based on the averages, I categorized users into three frequency segments: High (≥10/month), Medium (3–9/month), and Low (≤2/month).
- I then summarized the count of users per category, along with their average transaction frequency.

**Challenges:**
- The logic to compute monthly averages per user and then categorize them by frequency was complex.. I used CTEs `WITH` to break the logic into understandable parts, improving readability and reducing error risk.

---

### Q3: Account Inactivity Alert
**Objective: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days)**

**Approach:**
- Queried both savings and investment plans that had actual deposits `confirmed_amount > 0` and no recorded activity (based on `created_on` for over 365 days.
- I used `DATEDIFF` to calculate the inactivity duration and filtered for accounts with inactivity periods greater than one year.
- Used `UNION ALL` to combine the results from savings and investment plans for a general view.

**Challenges:**
- There was no dedicated transaction log table with timestamps, so I used the `created_on` field as a proxy for the last activity. This limitation was handled consistently across both savings and investment datasets.

---

### Q4: Customer Lifetime Value (CLV) Estimation
**Objective: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
- Account tenure (months since signup)
- Total transactions
- Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
- Order by estimated CLV from highest to lowest.**

**Approach:**
- I estimated CLV using the formula: `CLV = (total_transactions / tenure_in_months) * 12 * avg_profit_per_transaction`
- Calculated tenure as the number of months since account creation, counted total transactions, and derived average profit.
- Applied the CLV formula using the `0.1%` profit margin specified
- Ensured no division by zero by handling zero-tenure cases with a `NULLIF` safeguard.
- The final output ranks customers by estimated CLV in descending order.

**Challenges:** 
- Customers with very recent signup dates could result in zero-month tenure, which will mean dividing by `0`. `NULLIF` was used to prevent this and ensure query stability.
- Correctly applying the profit margin `0.1% = 0.001`.
