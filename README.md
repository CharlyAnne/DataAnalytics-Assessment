# Data Analytics Assessment

## Repo Overview
This repository contains SQL solutions to the Cowrywise Data Analyst assessment. The tasks involved quering a relational database to uncover customer insights and support business decisions accross savings and investment products.

### Q1: High-Value Customers with Multiple Products
Objective: Identify customers who have both a funded savings plan and a funded investment plan.
Approach: 
- Joined users_customuser, savings_savingsaccount, and plans_plan using the foreign key.
- Filtered savings using is_regular_savings = 1 and investments using is_a_fund = 1
- Ensured both plan types had a confirmed_amount > 0
