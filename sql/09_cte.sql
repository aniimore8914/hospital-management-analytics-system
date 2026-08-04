-- =========================================
-- HOSPITAL MANAGEMENT SYSTEM
-- COMMON TABLE EXPRESSIONS (CTE)
-- Author: Aniket More
-- =========================================

USE hospital_project;

#Revenue by Treatment
WITH treatment_revenue AS
(
    SELECT
        t.treatment_type,
        SUM(b.amount) AS revenue
    FROM treatments t
    JOIN billing b
        ON t.treatment_id = b.treatment_id
    GROUP BY t.treatment_type
)
SELECT *
FROM treatment_revenue
ORDER BY revenue DESC;

#Top Revenue Treatment
WITH treatment_revenue AS
(
    SELECT
        t.treatment_type,
        SUM(b.amount) AS revenue
    FROM treatments t
    JOIN billing b
        ON t.treatment_id = b.treatment_id
    GROUP BY t.treatment_type
)
SELECT *
FROM treatment_revenue
WHERE revenue =
(
    SELECT MAX(revenue)
    FROM treatment_revenue
);

#Doctor Performance
WITH doctor_stats AS
(
    SELECT
        d.doctor_id,
        CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
        COUNT(a.appointment_id) AS total_appointments
    FROM doctors d
    JOIN appointment a
        ON d.doctor_id = a.doctor_id
    GROUP BY d.doctor_id, doctor_name
)
SELECT *
FROM doctor_stats
ORDER BY total_appointments DESC;

#Doctors Above Average Appointments
WITH doctor_stats AS
(
    SELECT
        doctor_id,
        COUNT(*) AS total_appointments
    FROM appointment
    GROUP BY doctor_id
)
SELECT *
FROM doctor_stats
WHERE total_appointments >
(
    SELECT AVG(total_appointments)
    FROM doctor_stats
);


#Patient Spending Analysis
WITH patient_spending AS
(
    SELECT
        patient_id,
        SUM(amount) AS total_spent
    FROM billing
    GROUP BY patient_id
)
SELECT *
FROM patient_spending
ORDER BY total_spent DESC;

#High Value Patients
WITH patient_spending AS
(
    SELECT
        patient_id,
        SUM(amount) AS total_spent
    FROM billing
    GROUP BY patient_id
)
SELECT *
FROM patient_spending
WHERE total_spent >
(
    SELECT AVG(total_spent)
    FROM patient_spending
);

#Appointment Status Summary
WITH appointment_summary AS
(
    SELECT
        status,
        COUNT(*) AS total_count
    FROM appointment
    GROUP BY status
)
SELECT *
FROM appointment_summary;

#Multiple CTE Example
WITH doctor_revenue AS
(
    SELECT
        d.doctor_id,
        CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
        SUM(b.amount) AS revenue
    FROM doctors d
    JOIN appointment a
        ON d.doctor_id = a.doctor_id
    JOIN treatments t
        ON a.appointment_id = t.appointment_id
    JOIN billing b
        ON t.treatment_id = b.treatment_id
    GROUP BY d.doctor_id, doctor_name
),
average_revenue AS
(
    SELECT AVG(revenue) AS avg_revenue
    FROM doctor_revenue
)
SELECT *
FROM doctor_revenue
WHERE revenue >
(
    SELECT avg_revenue
    FROM average_revenue
);