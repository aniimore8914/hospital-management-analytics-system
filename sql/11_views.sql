-- =========================================
-- HOSPITAL MANAGEMENT SYSTEM
-- VIEWS
-- Author: Aniket More
-- =========================================

USE hospital_project;

#Patient Summary View
CREATE VIEW patient_summary AS
SELECT
    p.patient_id,
    CONCAT(p.first_name,' ',p.last_name) AS patient_name,
    p.gender,
    p.insurance_provider,
    COUNT(a.appointment_id) AS total_visits
FROM patients p
LEFT JOIN appointment a
ON p.patient_id = a.patient_id
GROUP BY p.patient_id,
         patient_name,
         p.gender,
         p.insurance_provider;
         
SELECT * FROM patient_summary;

#Doctor Performance View
CREATE VIEW doctor_performance AS
SELECT
    d.doctor_id,
    CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
    d.specialization,
    COUNT(a.appointment_id) AS total_appointments
FROM doctors d
LEFT JOIN appointment a
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id,
         doctor_name,
         d.specialization;
         
SELECT * FROM doctor_performance;

#Revenue by Treatment
CREATE VIEW treatment_revenue AS
SELECT
    t.treatment_type,
    SUM(b.amount) AS revenue
FROM treatments t
JOIN billing b
ON t.treatment_id = b.treatment_id
GROUP BY t.treatment_type;

SELECT * FROM treatment_revenue;

#Pending Payments View
CREATE VIEW pending_payments AS
SELECT
    p.patient_id,
    CONCAT(p.first_name,' ',p.last_name) AS patient_name,
    b.bill_id,
    b.amount
FROM patients p
JOIN billing b
ON p.patient_id = b.patient_id
WHERE b.payment_status = 'Pending';

SELECT * FROM pending_payments;

#Complete Patient Journey
CREATE VIEW patient_journey AS
SELECT
    p.patient_id,
    CONCAT(p.first_name,' ',p.last_name) AS patient_name,
    CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
    d.specialization,
    a.appointment_date,
    t.treatment_type,
    b.amount,
    b.payment_status
FROM patients p
JOIN appointment a
ON p.patient_id = a.patient_id
JOIN doctors d
ON a.doctor_id = d.doctor_id
JOIN treatments t
ON a.appointment_id = t.appointment_id
JOIN billing b
ON t.treatment_id = b.treatment_id;

SELECT * FROM patient_journey;

#Revenue Dashboard View
CREATE VIEW revenue_dashboard AS
SELECT
    payment_method,
    payment_status,
    SUM(amount) AS total_revenue
FROM billing
GROUP BY payment_method,
         payment_status;
         
SELECT * FROM revenue_dashboard;


SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';