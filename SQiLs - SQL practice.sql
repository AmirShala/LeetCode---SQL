'''These Questions are from https://www.sqils.io/ that have interactive exercises and real-world examples.
    Some of the questions where answered in SQLite. 
    '''
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


===========================================================================================================================================

Q2: Calculate Daily Work Hours

Mission Background
As a workforce analyst at a customer support center, you need to monitor shift hours for your team. The clockings_471 table records all login and logout events.


Analysis Requirements
Time Window: For each employee and date, identify the earliest clock-in time and latest clock-out time
Calculation: Compute the duration between these times expressed in hours with two decimal places
Filtering: Ensure every result has both IN and OUT events recorded

Success Criteria
Results show one row per employee per workday
Columns: employee_id, a new column representing the work date in YYYY-MM-DD format, and a new column representing the total hours worked as a numeric value
Hours calculated with precision to two decimal places
Ordering:

By date descending, then by employee ID ascending

Solution:

SELECT 
  employee_id,
  DATE(event_time) AS "WorkDate",
  ROUND(
    CAST(
      julianday(MAX(CASE WHEN event_type = 'OUT' THEN event_time END)) -
      julianday(MIN(CASE WHEN event_type = 'IN' THEN event_time END))
    AS REAL) * 24,
    2
  ) AS "HoursWorked"
FROM clockings_471
WHERE event_type IN ('IN', 'OUT')
GROUP BY employee_id, DATE(event_time)
HAVING MAX(CASE WHEN event_type = 'OUT' THEN event_time END) IS NOT NULL
   AND MIN(CASE WHEN event_type = 'IN' THEN event_time END) IS NOT NULL
ORDER BY "WorkDate" DESC, employee_id

===========================================================================================================================================

Q3: ssign Speakers To Rooms

Mission Background
As a Conference Organizer, you have a table of all possible speaker and room combinations. The conference_slots_645 table lists every speaker paired with every available room.


Analysis Requirements
From the full grid of combinations, produce a unique one to one assignment so that each speaker gets exactly one distinct room and no room is assigned to more than one speaker. Assign rooms in alphabetical order to speakers in alphabetical order.


Success Criteria
speaker_name
A new column representing the uniquely assigned room
Each speaker appears exactly once
Each room appears exactly once
The first alphabetical speaker gets the first alphabetical room, and so on
Ordering:

By speaker name ascending

Solution:

WITH ranked AS (
    SELECT
        speaker_name,
        room_name,
        ROW_NUMBER() OVER (PARTITION BY speaker_name ORDER BY room_name) AS room_seq,
        DENSE_RANK() OVER (ORDER BY speaker_name) AS speaker_seq
    FROM conference_slots_645
)
SELECT
    speaker_name AS "Speaker",
    room_name AS "AssignedRoom"
FROM ranked
WHERE room_seq = speaker_seq
ORDER BY speaker_name

===========================================================================================================================================

Q4: Abnormal Hire Gap Detection

Mission Background
As an HR Analyst, you want to identify periods of stagnant hiring. The employees table tracks hire dates that can reveal gaps in recruitment activity.


Analysis Requirements
Order employees by their hire date
Calculate the number of days between each hire and the previous hire
Identify employees hired after unusually long gaps

Success Criteria
Your query must return the following columns:

first_name: The employee first name
last_name: The employee last name
A column representing the days since the previous hire
Filtering Rules:

Only employees where the hire gap exceeds 300 days
Please note: The order of results does not matter.

Solution:

WITH HireSequences AS (
  SELECT 
    first_name AS FirstName,
    last_name AS LastName,
    julianday(hire_date) - julianday(LAG(hire_date) OVER (ORDER BY hire_date)) AS HireGap
  FROM employees
)
SELECT FirstName, LastName, HireGap 
FROM HireSequences 
WHERE HireGap > 300;

===========================================================================================================================================


===========================================================================================================================================
===========================================================================================================================================
===========================================================================================================================================
===========================================================================================================================================










































*/
