-- =========================================
-- HOSPITAL MANAGEMENT SYSTEM
-- Database Setup & Validation
-- Author: Aniket More
-- =========================================

CREATE DATABASE hospital_project;

USE hospital_project;

-- Verify tables
SHOW TABLES;

-- Check table structures
DESC patients;
DESC doctors;
DESC appointment;
DESC treatments;
DESC billing;

-- Verify data loaded correctly
SELECT * FROM patients LIMIT 5;
SELECT * FROM doctors LIMIT 5;
SELECT * FROM appointment LIMIT 5;
SELECT * FROM treatments LIMIT 5;
SELECT * FROM billing LIMIT 5;

-- Check record counts
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
