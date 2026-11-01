-- Analytics queries for the loaded tables

-- 1. Admissions and average stay by admission type
SELECT
    admission_type,
    COUNT(*) AS total_admissions,
    ROUND(AVG(los_days), 1) AS avg_stay_days
FROM admissions
GROUP BY admission_type
ORDER BY total_admissions DESC;

-- 2. Top 10 primary diagnoses
SELECT
    primary_dx_title,
    COUNT(*) AS total_admissions
FROM admissions
WHERE primary_dx_title IS NOT NULL
GROUP BY primary_dx_title
ORDER BY total_admissions DESC
LIMIT 10;

-- 3. In-hospital deaths by age group
SELECT
    CASE
        WHEN age_at_admit < 40 THEN 'under 40'
        WHEN age_at_admit < 60 THEN '40 to 59'
        WHEN age_at_admit < 80 THEN '60 to 79'
        ELSE '80 and above'
    END AS age_group,
    COUNT(*) AS total_admissions,
    SUM(hospital_expire_flag) AS deaths,
    ROUND(100.0 * SUM(hospital_expire_flag) / COUNT(*), 1) AS death_pct
FROM admissions
GROUP BY age_group
ORDER BY MIN(age_at_admit);

-- 4. Stay length and diagnoses by insurance
SELECT
    insurance,
    COUNT(*) AS total_admissions,
    ROUND(AVG(los_days), 1) AS avg_stay_days,
    ROUND(AVG(num_diagnoses), 1) AS avg_diagnoses
FROM admissions
GROUP BY insurance
ORDER BY total_admissions DESC;

-- Checks after loading
SELECT 'patients' AS table_name, COUNT(*) AS total_rows FROM patients
UNION ALL
SELECT 'admissions', COUNT(*) FROM admissions
UNION ALL
SELECT 'diagnoses', COUNT(*) FROM diagnoses;

SELECT COUNT(*) AS admissions_without_patient
FROM admissions a
LEFT JOIN patients p ON p.subject_id = a.subject_id
WHERE p.subject_id IS NULL;

SELECT COUNT(*) AS negative_stay_rows
FROM admissions
WHERE los_days < 0;

SELECT table_name, rows_read, rows_loaded, rows_rejected, run_time
FROM etl_log
ORDER BY id DESC
LIMIT 3;
