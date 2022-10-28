require 'post_repository'

RSpec.describe PostRepository do

def reset_posts_table
  seed_sql = File.read('spec/seeds_blog.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_new_test' })
  connection.exec(seed_sql)
end

before(:each) do
  reset_posts_table 
end

  it 'finds post with related tags' do
    repo = PostRepository.new

    post = repo.find_with_tags(2)

    expect(post.title).to eq 'My weekend in Edinburgh'
    expect(post.tags.length).to eq 2
  end
end