-- =========================================
-- HOSPITAL MANAGEMENT SYSTEM
-- SUBQUERIES
-- Author: Aniket More
-- =========================================

USE hospital_project;

#Patients Spending More Than Average
SELECT
    patient_id,
    amount
FROM billing
WHERE amount >
(
    SELECT AVG(amount)
    FROM billing
);

#Highest Revenue Patient
SELECT
    patient_id,
    SUM(amount) AS total_spent
FROM billing
GROUP BY patient_id
HAVING SUM(amount) =
(
    SELECT MAX(total_spent)
    FROM
    (
        SELECT patient_id,
               SUM(amount) AS total_spent
        FROM billing
        GROUP BY patient_id
    ) x
);

#Doctors Handling More Appointments Than Average
SELECT
    doctor_id,
    COUNT(*) AS total_appointments
FROM appointment
GROUP BY doctor_id
HAVING COUNT(*) >
(
    SELECT AVG(total_appointments)
    FROM
    (
        SELECT doctor_id,
               COUNT(*) AS total_appointments
        FROM appointment
        GROUP BY doctor_id
    ) x
);

#Treatments Costing More Than Average
SELECT
    treatment_type,
    cost
FROM treatments
WHERE cost >
(
    SELECT AVG(cost)
    FROM treatments
);

#Patients with Pending Bills
SELECT
    first_name,
    last_name
FROM patients
WHERE patient_id IN
(
    SELECT patient_id
    FROM billing
    WHERE payment_status = 'Pending'
);

#Doctors Who Have Completed Appointments
SELECT
    first_name,
    last_name
FROM doctors
WHERE doctor_id IN
(
    SELECT doctor_id
    FROM appointment
    WHERE status = 'Completed'
);

#Patients Who Visited More Than Once
SELECT
    patient_id,
    COUNT(*) AS visits
FROM appointment
GROUP BY patient_id
HAVING COUNT(*) > 1;

#Treatment Generating Highest Revenue
SELECT
    treatment_type,
    revenue
FROM
(
    SELECT
        t.treatment_type,
        SUM(b.amount) AS revenue
    FROM treatments t
    JOIN billing b
    ON t.treatment_id = b.treatment_id
    GROUP BY t.treatment_type
) x
WHERE revenue =
(
    SELECT MAX(revenue)
    FROM
    (
        SELECT
            t.treatment_type,
            SUM(b.amount) AS revenue
        FROM treatments t
        JOIN billing b
        ON t.treatment_id = b.treatment_id
        GROUP BY t.treatment_type
    ) y
);


