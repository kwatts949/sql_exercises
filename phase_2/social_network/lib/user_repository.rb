require_relative './users'

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

  def find(id)
    sql = 'SELECT id, username, email_address FROM users WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    user = User.new
    user.id = record['id']
    user.username = record['username']
    user.email_address = record['email_address']

    return user
  end

  def create(user)
    sql = 'INSERT INTO users (username, email_address) VALUES ($1, $2);'
    sql_params = [user.username, user.email_address]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    
    return nil
  end

  def delete(id)
    sql = 'DELETE FROM users WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
  return nil
  end
end