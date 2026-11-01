# Hospital Admissions ETL Pipeline

A simple ETL pipeline made with Python, PySpark and PostgreSQL. It takes real hospital data, cleans it, adds a few new columns, loads it into a database and runs SQL queries on it.

## Dataset

I used the [MIMIC-IV Clinical Database Demo](https://physionet.org/content/mimic-iv-demo/2.2/) from PhysioNet. It has real hospital records of 100 patients, with names and other identities removed. It is free to download.

Four tables are used:
- patients: one row per patient
- admissions: one row per hospital stay
- diagnoses_icd: diagnosis codes for each stay
- d_icd_diagnoses: names of the diagnosis codes

The notebook downloads these files by itself, so the data is not stored in this repo.

## What the Pipeline Does

1. **Extract:** download the 4 files and read them with PySpark.
2. **Transform:** clean the data, check its quality, remove bad rows and add new columns (length of stay, age at admission, number of diagnoses, main diagnosis).
3. **Load:** load the tables into Neon PostgreSQL and save row counts in an `etl_log` table.
4. **Analytics:** run SQL queries on the loaded tables.

## Data Quality Checks

- duplicate patient and admission ids
- missing admission time
- discharge time before admission time
- admissions without a matching patient
- diagnoses without a matching admission

## Tools Used

Python, PySpark, PostgreSQL (Neon), SQL, Google Colab

## Project Structure

```
hospital-etl-pipeline/
├── notebooks/
│   └── hospital_etl_pipeline.ipynb
├── sql/
│   ├── create_tables.sql
│   └── analytics_queries.sql
├── .gitignore
└── README.md
```

## Data Source

Johnson, A., Bulgarelli, L., Pollard, T., Horng, S., Celi, L. A., & Mark, R. (2023). MIMIC-IV Clinical Database Demo (version 2.2). PhysioNet. https://doi.org/10.13026/dp1f-ex47
