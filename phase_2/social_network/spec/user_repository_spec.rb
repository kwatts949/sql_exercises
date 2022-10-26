require 'user_repository'

RSpec.describe UserRepository do

def reset_users_table
  seed_sql = File.read('spec/seeds_users.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end


before(:each) do 
  reset_users_table
end

  it 'returns a list of all the users' do
    repo = UserRepository.new

    users = repo.all

    expect(users.length).to eq 2
    expect(users.first.username).to eq 'David5'
    expect(users.last.email_address).to eq 'annafour@mail.com'
  end

  it 'returns a single user' do
    repo = UserRepository.new
    user = repo.find(2)
    expect(user.id).to eq '2'
  end

  it 'creates a new user' do
    repo = UserRepository.new
    new_user = User.new
    new_user.username = 'Samatha'
    new_user.email_address = 'sam@gmail.com'
    repo.create(new_user)
    all_users = repo.all
    expect(all_users).to include(
    have_attributes(
    username: new_user.username,
    email_address: new_user.email_address
    )
  )
  end

  it 'removes the worst user' do
    repo = UserRepository.new
    repo.delete(1)
    users = repo.all
    expect(users.length).to eq 1
    expect(users.first.username).to eq 'Ann4'
  end
end