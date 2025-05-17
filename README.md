# An Interview Data Analytics Assessment

### Q1: High-Value Customers with Multiple Products
So this query will identify users who have at least one funded savings plan and one funded investment plan. The `users_customuser` table will join with the aggregate counts and sums from the `savings_savingsaccount` and `plans_plan` tables, calculates total deposits (converted from kobo to naira), and sorts by total deposits.

### Q2: Transaction Frequency Analysis
Calculating the average number of transactions (based on `confirmed_amount > 0`) per customer per month. Using a CTE, we grouped by customer and month, then averaged these to segment users into high (≥10), medium (3–9), and low (≤2) frequency buckets.

### Q3: Account Inactivity Alert

Query will extracte the latest inflow (`confirmed_amount > 0`) for each active savings and investment plan. Any active account without a transaction in the last 365 days should be flagged, showing the last transaction date and number of inactivity days. A `JOIN` will be used to combine savings and investment plans into one list.

### Q4: Customer Lifetime Value (CLV) Estimation

To provide a simplified forecast of a customer’s projected annual value based on activity, the CLV will be calculated using:
- Tenure (months since signup using `date_joined`)
- Profit per transaction as 0.1% of confirmed inflows
- Formula: `(total_transactions / tenure_months) * 12 * avg_profit_per_transaction`

## Challenges & How I Solved Them

- **Kobo to Naira**: Remembered to divide amounts by 100.
