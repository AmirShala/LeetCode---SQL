"""
A curated collection of SQL interview questions from StrataScratch.com,
covering a wide range of difficulty levels—from basic queries to advanced analytical challenges—designed to strengthen problem-solving and real-world data skills. 
  


Q: Users By Average Session Time
Calculate each user's average session time, where a session is defined as the time difference between a page_load and a page_exit.
  Assume each user has only one session per day. If there are multiple page_load or page_exit events on the same day, use only the latest page_load and the earliest page_exit.
  Only consider sessions where the page_load occurs before the page_exit on the same day. Output the user_id and their average session time.

Table
facebook_web_log
action: varchar
timestamp: datetime2
user_id: bigint


Solution:

WITH loads AS (
  SELECT
    user_id,
    CAST(timestamp AS DATE) AS day,
    MAX(timestamp) AS load_time
  FROM facebook_web_log
  WHERE action = 'page_load'
  GROUP BY user_id, CAST(timestamp AS DATE)
),
exits AS (
  SELECT
    user_id,
    CAST(timestamp AS DATE) AS day,
    MIN(timestamp) AS exit_time
  FROM facebook_web_log
  WHERE action = 'page_exit'
  GROUP BY user_id, CAST(timestamp AS DATE)
),
sessions AS (
  SELECT
    l.user_id,
    l.load_time,
    e.exit_time,
    DATEDIFF(SECOND, l.load_time, e.exit_time) AS session_duration
  FROM loads l
  JOIN exits e
    ON l.user_id = e.user_id AND l.day = e.day
  WHERE l.load_time < e.exit_time
)
SELECT
  user_id,
  AVG(session_duration * 1.0) AS avg_session_duration
FROM sessions
GROUP BY user_id;

==================================================================================================================

  Question: Finding Updated Records

We have a table with employees and their salaries; however, some of the records are old and contain outdated salary information.
  Since there is no timestamp, assume salary is non-decreasing over time.
  You can consider the current salary for an employee is the largest salary value among their records.
  If multiple records share the same maximum salary, return any one of them. Output their id, first name,
  last name, department ID, and current salary. Order your list by employee ID in ascending order.

Table- 
  
ms_employee_salary
department_id:bigint
first_name:varchar
id:bigint
last_name:varchar
salary:bigint

  Solution:

  SELECT id,
       first_name,
       last_name,
       department_id,
       salary
FROM (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY id ORDER BY salary DESC, department_id DESC) AS rn
  FROM ms_employee_salary
) s
WHERE rn = 1
ORDER BY id ASC;

==================================================================================================================

Question: Total Cost Of Orders

Find the total cost of each customer's orders. Output customer's id, first name, and the total order cost.
Order records by customer's first name alphabetically.

Tables-
  
customers
address:varchar
city:varchar
first_name:varchar
id:bigint
last_name:varchar
phone_number:varchar

orders
cust_id:bigint
id:bigint
order_date:date
order_details:varchar
total_order_cost:bigint


  Solution:

  SELECT customers.id,
       customers.first_name,
       SUM(total_order_cost) AS total_cost
FROM orders
JOIN customers ON customers.id = orders.cust_id
GROUP BY customers.id,
         customers.first_name
ORDER BY customers.first_name ASC;

==================================================================================================================

Question:

Acceptance Rate By Date

Calculate the friend acceptance rate for each date when friend requests were sent.
  A request is sent if action = sent and accepted if action = accepted.
  If a request is not accepted, there is no record of it being accepted in the table.
The output will only include dates where requests were sent and at least one of them was accepted (acceptance can occur on any date after the request is sent).

Table
fb_friend_requests
action:varchar
date:date
user_id_receiver:varchar
user_id_sender:varchar

  Solution:
WITH sent_cte AS
  (SELECT date, user_id_sender,
                user_id_receiver
   FROM fb_friend_requests
   WHERE action='sent' ),
     accepted_cte AS
  (SELECT date, user_id_sender,
                user_id_receiver
   FROM fb_friend_requests
   WHERE action='accepted' )
SELECT a.date,
       count(b.user_id_receiver)/CAST(count(a.user_id_sender) AS decimal) AS percentage_acceptance
FROM sent_cte a
LEFT JOIN accepted_cte b ON a.user_id_sender=b.user_id_sender
AND a.user_id_receiver=b.user_id_receiver
GROUP BY a.date
  
==================================================================================================================
==================================================================================================================
==================================================================================================================
==================================================================================================================
==================================================================================================================
==================================================================================================================
==================================================================================================================
==================================================================================================================
==================================================================================================================
==================================================================================================================
==================================================================================================================
  
















  
"""
