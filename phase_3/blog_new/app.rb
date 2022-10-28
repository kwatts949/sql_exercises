require_relative './lib/database_connection'
require_relative './lib/post_repository'

class Application
  def initialize(database_name, io, post_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @post_repository = post_repository
  end

  def run
    while true do
    @io.puts "Please select 1 to find posts by tag or 2 to find tags by post"
    selection = @io.gets.chomp
      if selection == '1'
        @io.puts "Enter 1 for 'coding', 2 for 'travel', 3 for 'cooking', 4 for 'ruby' or 5 for 'sql'"
        choice = @io.gets.chomp
        return posts(choice)
      elsif selection == '2'
         @io.puts "Enter any number from 1 to 7"
        choice = @io.gets.chomp
        return tags(choice)
      else
        @io.puts 'Not a valid selection'
      end
    end
  end

  private

   def posts(tag)
    sql = 'SELECT posts.id, posts.title
            FROM posts 
            JOIN posts_tags ON posts_tags.post_id = posts.id
            JOIN tags ON posts_tags.tag_id = tags.id
          WHERE tags.id = $1;'

    result_set = DatabaseConnection.exec_params(sql, [tag])
      result_set.each do |record|
        p record.values
    end
  end

     def tags(post)
    sql = 'SELECT tags.id, tags.name
            FROM tags 
            JOIN posts_tags ON posts_tags.tag_id = tags.id
            JOIN posts ON posts_tags.post_id = posts.id
          WHERE posts.id = $1;'

    result_set = DatabaseConnection.exec_params(sql, [post])
      result_set.each do |record|
        p record.values
    end
  end

  if __FILE__ == $0
  app = Application.new(
    'blog_new_test',
    Kernel,
    PostRepository.new
  )
  app.run
  end
end