-- =========================================
-- HOSPITAL MANAGEMENT SYSTEM
-- BUSINESS KPIs DASHBOARD
-- Author: Aniket More
-- =========================================

USE hospital_project;

#Total Revenue
SELECT
    SUM(amount) AS total_revenue
FROM billing;

#Pending Revenue
SELECT
    SUM(amount) AS pending_revenue
FROM billing
WHERE payment_status='Pending';

#Average Bill Amount
SELECT
    ROUND(AVG(amount),2) AS average_bill
FROM billing;

#Appointment Completion Rate
SELECT
ROUND(
(
COUNT(CASE WHEN status='Completed' THEN 1 END)
*100.0
)/COUNT(*),2
) AS completion_rate
FROM appointment;

#Top Revenue Treatment
SELECT
    t.treatment_type,
    SUM(b.amount) AS revenue
FROM treatments t
JOIN billing b
ON t.treatment_id=b.treatment_id
GROUP BY t.treatment_type
ORDER BY revenue DESC
LIMIT 1;

#Top Doctor By Revenue
SELECT
CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
SUM(b.amount) AS revenue
FROM doctors d
JOIN appointment a
ON d.doctor_id=a.doctor_id
JOIN treatments t
ON a.appointment_id=t.appointment_id
JOIN billing b
ON t.treatment_id=b.treatment_id
GROUP BY doctor_name
ORDER BY revenue DESC
LIMIT 1;

#Top Spending Patient
SELECT
CONCAT(p.first_name,' ',p.last_name) AS patient_name,
SUM(b.amount) AS total_spent
FROM patients p
JOIN billing b
ON p.patient_id=b.patient_id
GROUP BY patient_name
ORDER BY total_spent DESC
LIMIT 1;

#Most Common Treatment
SELECT
treatment_type,
COUNT(*) AS treatment_count
FROM treatments
GROUP BY treatment_type
ORDER BY treatment_count DESC
LIMIT 1;

#Most Common Visit Reason
SELECT
reason_for_visit,
COUNT(*) AS visit_count
FROM appointment
GROUP BY reason_for_visit
ORDER BY visit_count DESC
LIMIT 1;

#Revenue By Payment Method
SELECT
payment_method,
SUM(amount) AS revenue
FROM billing
GROUP BY payment_method
ORDER BY revenue DESC;