require 'post_repository'

RSpec.describe PostRepository do

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_test' })
  connection.exec(seed_sql)
end

before(:each) do
  reset_posts_table 
end

  it 'finds post with related comments' do
    repo = PostRepository.new

    post = repo.find_with_comments(2)

    expect(post.title).to eq 'May'
    expect(post.comments.length).to eq 2
  end

  it 'finds post with related comments' do
    repo = PostRepository.new

    post = repo.find_with_comments(1)

    expect(post.title).to eq 'April'
    expect(post.comments.length).to eq 3
    expect(post.comments.first.comment_content).to eq "Yess!"
  end
end