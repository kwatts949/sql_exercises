class UserRepository
  def all
  sql = 'SELECT id, username, email_address FROM users;'
  result_set = DatabaseConnection.exec_params(sql, [])

  users = []

    result_set.each do |record|
      user = User.new
      user.id = record['id']
      user.username = record['username']
      user.email_address = record['email_address']
      users << user
    end
  return users
  end
end
=begin
  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students WHERE id = $1;

    # Returns a single Student object.
  end

  def create
  end

  def delete
  end
end
=end