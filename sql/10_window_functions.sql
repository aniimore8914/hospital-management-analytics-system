-- =========================================
-- HOSPITAL MANAGEMENT SYSTEM
-- WINDOW FUNCTIONS
-- Author: Aniket More
-- =========================================

USE hospital_project;

#Rank Doctors by Revenue
SELECT
    CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
    SUM(b.amount) AS revenue,
    RANK() OVER(
        ORDER BY SUM(b.amount) DESC
    ) AS revenue_rank
FROM doctors d
JOIN appointment a
    ON d.doctor_id = a.doctor_id
JOIN treatments t
    ON a.appointment_id = t.appointment_id
JOIN billing b
    ON t.treatment_id = b.treatment_id
GROUP BY doctor_name;

#Row Number for Doctors
SELECT
    CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
    SUM(b.amount) AS revenue,
    ROW_NUMBER() OVER(
        ORDER BY SUM(b.amount) DESC
    ) AS row_num
FROM doctors d
JOIN appointment a
    ON d.doctor_id = a.doctor_id
JOIN treatments t
    ON a.appointment_id = t.appointment_id
JOIN billing b
    ON t.treatment_id = b.treatment_id
GROUP BY doctor_name;

#Dense Rank
SELECT
    CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
    SUM(b.amount) AS revenue,
    DENSE_RANK() OVER(
        ORDER BY SUM(b.amount) DESC
    ) AS dense_rank_no
FROM doctors d
JOIN appointment a
    ON d.doctor_id = a.doctor_id
JOIN treatments t
    ON a.appointment_id = t.appointment_id
JOIN billing b
    ON t.treatment_id = b.treatment_id
GROUP BY doctor_name;

#Top Spending Patients
SELECT
    patient_id,
    SUM(amount) AS total_spent,
    RANK() OVER(
        ORDER BY SUM(amount) DESC
    ) AS patient_rank
FROM billing
GROUP BY patient_id;

#Revenue by Treatment Ranking
SELECT
    t.treatment_type,
    SUM(b.amount) AS revenue,
    RANK() OVER(
        ORDER BY SUM(b.amount) DESC
    ) AS revenue_rank
FROM treatments t
JOIN billing b
    ON t.treatment_id = b.treatment_id
GROUP BY t.treatment_type;

#Partition By Specialization
SELECT
    specialization,
    first_name,
    last_name,
    years_experience,
    RANK() OVER(
        PARTITION BY specialization
        ORDER BY years_experience DESC
    ) AS exp_rank
FROM doctors;

#Running Revenue Total
SELECT
    bill_date,
    amount,
    SUM(amount) OVER(
        ORDER BY bill_date
    ) AS running_total
FROM billing;

#Average Revenue Comparison
SELECT
    bill_id,
    amount,
    AVG(amount) OVER() AS overall_avg_bill
FROM billing;

#Revenue Difference from Average
SELECT
    bill_id,
    amount,
    amount - AVG(amount) OVER() AS diff_from_avg
FROM billing;


