
require 'posts_repository'

RSpec.describe PostRepository do
def reset_users_table
  seed_sql = File.read('spec/seeds_users.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

before(:each) do 
  reset_users_table
  reset_posts_table
end

  it 'returns a list of all the posts' do
    repo = PostRepository.new

    posts = repo.all

    expect(posts.length).to eq 4
    expect(posts.first.title ).to eq 'Cats'
    expect(posts.last.content).to eq 'Cake'
  end

  it 'returns a single post' do
    repo = PostRepository.new

    post = repo.find(3)

    expect(post.id).to eq '3'
    expect(post.title).to eq 'Interesting!'
    expect(post.content).to eq "Telegraph poles"
    expect(post.views).to eq '0'
    expect(post.user_id).to eq '1'
  end

   it 'creates a new post' do
    repo = PostRepository.new

    new_post = Post.new
    new_post.title = 'Horses'
    new_post.content = 'Types'
    new_post.views = "7"
    new_post.user_id = "2"

    repo.create(new_post)

    all_posts = repo.all

    expect(all_posts).to include(
    have_attributes(
    title: new_post.title,
    content: new_post.content,
    views: new_post.views,
    user_id: new_post.user_id
    )
  )
  end

  it 'removes the worst post' do
    repo = PostRepository.new
    repo.delete(1)
    posts = repo.all
    expect(posts.length).to eq 3
  end
end