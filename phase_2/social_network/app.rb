require_relative 'lib/database_connection'
require_relative 'lib/user_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('social_network')

user_repo = UserRepository.new

user_repo.all.each do |user| # all method working
  p user.username
end

user = user_repo.find(2) # find method working
  p user.username
  p user.email_address

new_user = User.new # create method working
new_user.username = "Miguel"
new_user.email_address = 'miguel42@hotmail.com'

user = user_repo.create(new_user)
  p new_user.username

