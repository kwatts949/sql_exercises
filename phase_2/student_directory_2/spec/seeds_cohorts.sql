TRUNCATE TABLE cohorts RESTART IDENTITY CASCADE;
TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.

INSERT INTO cohorts (name, start_date) VALUES ('April', '04');
INSERT INTO cohorts (name, start_date) VALUES ('May', '05');

INSERT INTO students (student_name, cohort_id) VALUES ('David', '1');
INSERT INTO students (student_name, cohort_id) VALUES ('Anna', '2');
INSERT INTO students (student_name, cohort_id) VALUES ('Sindy', '2');
INSERT INTO students (student_name, cohort_id) VALUES ('Bella', '2');
INSERT INTO students (student_name, cohort_id) VALUES ('James', '2');
