require 'cohort_repository'

RSpec.describe CohortRepository do

def reset_cohorts_table
  seed_sql = File.read('spec/seeds_cohorts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2_test' })
  connection.exec(seed_sql)
end

before(:each) do
  reset_cohorts_table 
end

  it 'finds cohort with related students' do
    repo = CohortRepository.new

    cohort = repo.find_with_students(2)

    expect(cohort.name).to eq 'May'
    expect(cohort.students.length).to eq 4
    expect(cohort.start_date).to eq "5"
  end

  it 'finds cohort with related students' do
    repo = CohortRepository.new

    cohort = repo.find_with_students(1)

    expect(cohort.name).to eq 'April'
    expect(cohort.students.length).to eq 1
    expect(cohort.start_date).to eq "4"
  end
end