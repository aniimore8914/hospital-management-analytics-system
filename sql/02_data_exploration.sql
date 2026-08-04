-- =========================================
-- HOSPITAL MANAGEMENT SYSTEM
-- DATA EXPLORATION
-- Author: Aniket More
-- =========================================

USE hospital_project;

SELECT COUNT(*) AS total_patients
FROM patients;

SELECT COUNT(*) AS total_doctors
FROM doctors;

SELECT COUNT(*) AS total_appointments
FROM appointment;

SELECT COUNT(*) AS total_treatments
FROM treatments;

SELECT COUNT(*) AS total_bills
FROM billing;

#Gender Distribution
SELECT
    gender,
    COUNT(*) AS total_patients
FROM patients
GROUP BY gender;

#Appointment Status
SELECT
    status,
    COUNT(*) AS total_appointments
FROM appointment
GROUP BY status;

#Treatment Distribution
SELECT
    treatment_type,
    COUNT(*) AS total_treatments
FROM treatments
GROUP BY treatment_type
ORDER BY total_treatments DESC;

#Doctor Specialization Distribution
SELECT
    specialization,
    COUNT(*) AS total_doctors
FROM doctors
GROUP BY specialization
ORDER BY total_doctors DESC;

#Insurance Provider Distribution
SELECT
    insurance_provider,
    COUNT(*) AS total_patients
FROM patients
GROUP BY insurance_provider
ORDER BY total_patients DESC;

#Payment Status Distribution
SELECT
    payment_status,
    COUNT(*) AS total_bills
FROM billing
GROUP BY payment_status;