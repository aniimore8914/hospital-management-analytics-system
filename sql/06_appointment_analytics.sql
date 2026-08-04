-- =========================================
-- HOSPITAL MANAGEMENT SYSTEM
-- APPOINTMENT ANALYTICS
-- Author: Aniket More
-- =========================================

USE hospital_project;

#Total Appointments
SELECT COUNT(*) AS total_appointments
FROM appointment;

#Appointment Status Distribution
SELECT
    status,
    COUNT(*) AS total_appointments
FROM appointment
GROUP BY status
ORDER BY total_appointments DESC;

#Appointment Success Rate
SELECT
    ROUND(
        (COUNT(CASE WHEN status = 'Completed' THEN 1 END) * 100.0)
        / COUNT(*),
        2
    ) AS completion_rate
FROM appointment;

#Most Common Visit Reasons
SELECT
    reason_for_visit,
    COUNT(*) AS total_visits
FROM appointment
GROUP BY reason_for_visit
ORDER BY total_visits DESC;

#Top 5 Most Common Visit Reasons
SELECT
    reason_for_visit,
    COUNT(*) AS total_visits
FROM appointment
GROUP BY reason_for_visit
ORDER BY total_visits DESC
LIMIT 5;

#Appointments by Doctor
SELECT
    d.first_name,
    d.last_name,
    COUNT(a.appointment_id) AS total_appointments
FROM doctors d
JOIN appointment a
ON d.doctor_id = a.doctor_id
GROUP BY d.first_name,
         d.last_name
ORDER BY total_appointments DESC;

#Top 5 Busiest Doctors
SELECT
    d.first_name,
    d.last_name,
    COUNT(a.appointment_id) AS total_appointments
FROM doctors d
JOIN appointment a
ON d.doctor_id = a.doctor_id
GROUP BY d.first_name,
         d.last_name
ORDER BY total_appointments DESC
LIMIT 5;

#Appointments by Date
SELECT
    appointment_date,
    COUNT(*) AS total_appointments
FROM appointment
GROUP BY appointment_date
ORDER BY total_appointments DESC;

#Cancelled Appointments
SELECT
    COUNT(*) AS cancelled_appointments
FROM appointment
WHERE status = 'Cancelled';

#No-Show Appointments
SELECT
    COUNT(*) AS no_show_appointments
FROM appointment
WHERE status = 'No-show';

#Doctor-wise Completed Appointments
SELECT
    d.first_name,
    d.last_name,
    COUNT(*) AS completed_appointments
FROM doctors d
JOIN appointment a
ON d.doctor_id = a.doctor_id
WHERE a.status = 'Completed'
GROUP BY d.first_name,
         d.last_name
ORDER BY completed_appointments DESC;