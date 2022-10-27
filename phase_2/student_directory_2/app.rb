require_relative './lib/database_connection'
require_relative './lib/cohort_repository'

class Application
  def initialize(database_name, io, cohort_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @cohort_repository = cohort_repository
  end

  def run
    @io.puts "Please select 1 for 'April' or 2 for 'May'"
    selection = @io.gets.chomp
      if selection == '1'
        return cohorts(1)
      elsif selection == '2'
        return cohorts(2)
      end
  end

  private

   def cohorts(month)
    sql = 'SELECT cohorts.name AS "name",
	          students.student_name AS "student_name"
	        FROM cohorts 
	          JOIN students
	          ON students.cohort_id = cohorts.id
	         WHERE cohort_id = $1'
    result_set = DatabaseConnection.exec_params(sql, [month])
      result_set.each do |record|
        p record.values
    end
  end

  if __FILE__ == $0
  app = Application.new(
    'student_directory_2_test',
    Kernel,
    CohortRepository.new
  )
  app.run
  end
end