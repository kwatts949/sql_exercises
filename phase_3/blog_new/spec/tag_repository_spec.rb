require 'tag_repository'

RSpec.describe TagRepository do

def reset_posts_table
  seed_sql = File.read('spec/seeds_blog.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_new_test' })
  connection.exec(seed_sql)
end

before(:each) do
  reset_posts_table 
end

  it 'takes a post and returns its related tags' do
    repo = TagRepository.new

    tag = repo.find_by_post(2)

    expect(tag.name).to eq 'coding'
    expect(tag.posts.length).to eq 2
  end
end