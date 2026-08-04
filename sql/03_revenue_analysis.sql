-- =========================================
-- HOSPITAL MANAGEMENT SYSTEM
-- REVENUE ANALYSIS
-- Author: Aniket More
-- =========================================

USE hospital_project;

#Total Hospital Revenue
SELECT
    SUM(amount) AS total_revenue
FROM billing;

#Average Bill Amount
SELECT
    AVG(amount) AS average_bill_amount
FROM billing;

#Highest Bill
SELECT
    MAX(amount) AS highest_bill
FROM billing;

#Lowest Bill
SELECT
    MIN(amount) AS lowest_bill
FROM billing;

#Revenue by Payment Method
SELECT
    payment_method,
    SUM(amount) AS total_revenue
FROM billing
GROUP BY payment_method
ORDER BY total_revenue DESC;

#Revenue by Payment Status
SELECT
    payment_status,
    SUM(amount) AS total_amount
FROM billing
GROUP BY payment_status;

#Pending Revenue
SELECT
    SUM(amount) AS pending_revenue
FROM billing
WHERE payment_status = 'Pending';

#Revenue by Treatment Type
SELECT
    t.treatment_type,
    SUM(b.amount) AS revenue
FROM treatments t
JOIN billing b
ON t.treatment_id = b.treatment_id
GROUP BY t.treatment_type
ORDER BY revenue DESC;

#Top 5 Revenue Generating Treatments
SELECT
    t.treatment_type,
    SUM(b.amount) AS revenue
FROM treatments t
JOIN billing b
ON t.treatment_id = b.treatment_id
GROUP BY t.treatment_type
ORDER BY revenue DESC
LIMIT 5;