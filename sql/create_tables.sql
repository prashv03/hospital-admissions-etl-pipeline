CREATE TABLE IF NOT EXISTS patients (
    subject_id INTEGER PRIMARY KEY,
    gender VARCHAR(1),
    anchor_age INTEGER,
    anchor_year INTEGER,
    anchor_year_group TEXT,
    dod TIMESTAMP
);

CREATE TABLE IF NOT EXISTS admissions (
    hadm_id INTEGER PRIMARY KEY,
    subject_id INTEGER NOT NULL REFERENCES patients (subject_id),
    admittime TIMESTAMP NOT NULL,
    dischtime TIMESTAMP,
    admission_type TEXT,
    admission_location TEXT,
    discharge_location TEXT,
    insurance TEXT,
    language TEXT,
    marital_status TEXT,
    race TEXT,
    hospital_expire_flag SMALLINT,
    los_days NUMERIC(8, 2),
    age_at_admit INTEGER,
    num_diagnoses INTEGER,
    primary_dx_code TEXT,
    primary_dx_title TEXT
);

CREATE TABLE IF NOT EXISTS diagnoses (
    hadm_id INTEGER NOT NULL REFERENCES admissions (hadm_id),
    seq_num INTEGER NOT NULL,
    icd_code TEXT,
    icd_version SMALLINT,
    dx_title TEXT,
    PRIMARY KEY (hadm_id, seq_num)
);

CREATE TABLE IF NOT EXISTS etl_log (
    id SERIAL PRIMARY KEY,
    run_time TIMESTAMP DEFAULT NOW(),
    table_name TEXT,
    rows_read INTEGER,
    rows_loaded INTEGER,
    rows_rejected INTEGER
);
