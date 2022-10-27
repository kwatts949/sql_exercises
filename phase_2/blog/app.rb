require_relative './lib/database_connection'
require_relative './lib/post_repository'

class Application
  def initialize(database_name, io, post_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @post_repository = post_repository
  end

  def run
    @io.puts "Please select 1 for 'April Posts' or 2 for 'May Posts'"
    selection = @io.gets.chomp
      if selection == '1'
        return posts(1)
      elsif selection == '2'
        return posts(2)
      end
  end

  private

   def posts(month)
    sql = 'SELECT posts.title AS "title",
            posts.content AS "content",
	          comments.comment_content AS "comment_content"
	        FROM posts 
	          JOIN comments
	          ON comments.post_id = posts.id
	         WHERE post_id = $1'
    result_set = DatabaseConnection.exec_params(sql, [month])

    result_set.each do |record|
      p record.values
    end
  end

  if __FILE__ == $0
  app = Application.new(
    'blog_test',
    Kernel,
    PostRepository.new
  )
  app.run
  end
end