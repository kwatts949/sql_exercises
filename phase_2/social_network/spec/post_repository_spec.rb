
=begin
def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'posts' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_users_table
  end
end
=end