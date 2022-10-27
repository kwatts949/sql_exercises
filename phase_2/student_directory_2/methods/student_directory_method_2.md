Two Tables Design Recipe Template

1. Extract nouns from the user stories or specification
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a coach
So I can get to know all students
I want to see a list of students' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' starting dates.

As a coach
So I can get to know all students
I want to see a list of students' cohorts.

Nouns:

student names, cohort names, starting dates, 

2. Infer the Table Name and Columns

Record	Properties
cohorts	name, start_date
student	name, cohort_id

Name of the first table (always plural): cohorts

Column names: name, start_date

Name of the second table (always plural): students

Column names: name, cohort_id

3. Decide the column types.
Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# EXAMPLE:

Table: cohorts
id: SERIAL
names: text
start_date: int

Table: students
id: SERIAL
name: text
cohort_id: int

4. Decide on The Tables Relationship
Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

To decide on which one, answer these two questions:

Can one [cohort ] have many [students]? (Yes/No) Yes
Can one [student ] have many [cohorts]? (Yes/No) No
You'll then be able to say that:

[cohorts] has many [students]
And on the other side, [students] belongs to [cohorts]
In that case, the foreign key is in the table [students]
Replace the relevant bits in this example with your own:

4. Write the SQL.
-- EXAMPLE
-- file: cohorts_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  name text,
  start_date int
);

CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name text,
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id)
    references cohorts(id)
    on delete cascade
);
5. Create the tables.
psql -h 127.0.0.1 database_name < albums_table.sql