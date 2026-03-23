'''These Questions are from https://www.sqils.io/ that have interactive exercises and real-world examples.'''
/*
Q1:CAC Payback by Channel

Mission Background
As a Finance Analyst at a SaaS startup, your CFO needs to evaluate the efficiency of each acquisition channel. Customer Acquisition Cost (CAC) tells you how much you spend to acquire one customer, while the Payback Period tells you how many months of revenue it takes to recover that cost. Use the customers_771, campaigns_771, and subscriptions_771 tables to calculate both metrics per channel.


Analysis Requirements
Join the three tables to calculate CAC (total spend divided by number of customers) and Payback Period (CAC divided by average MRR) per acquisition channel.


Success Criteria
Your result should include:

channel — the acquisition channel name
CAC — Customer Acquisition Cost (total spend / number of customers), rounded to 2 decimals
AvgMRR — average Monthly Recurring Revenue per customer in that channel, rounded to 2 decimals
PaybackMonths — number of months to recover CAC (CAC / AvgMRR), rounded to 1 decimal
Ordering:

By payback months from lowest to highest

Solution:

SELECT
    ca.channel,
    ROUND(ca.total_spend / NULLIF(COUNT(DISTINCT c.customer_id), 0), 2) AS "CAC",
    ROUND(AVG(s.mrr), 2) AS "AvgMRR",
    ROUND(ca.total_spend / NULLIF(COUNT(DISTINCT c.customer_id), 0) / NULLIF(AVG(s.mrr), 0), 1) AS "PaybackMonths"
FROM campaigns_771 ca
JOIN customers_771 c ON c.acquisition_channel = ca.channel
JOIN subscriptions_771 s ON c.customer_id = s.customer_id
GROUP BY ca.channel, ca.total_spend
ORDER BY "PaybackMonths"













































*/
