require_relative './posts'
require_relative './comments'

class PostRepository
  def find_with_comments(post_id)
    sql = 'SELECT posts.id AS "id",
	          posts.title AS "title",
	          posts.content AS "content",
            comments.id AS "comment_id",
	          comments.comment_content AS "comment_content"
	        FROM posts 
	          JOIN comments
	          ON comments.post_id = posts.id
	         WHERE post_id = $1;'
      sql_params = [post_id]

      result_set = DatabaseConnection.exec_params(sql, sql_params)

      first_record = result_set[0]

      post = record_to_post_object(first_record)

      result_set.each do |record|
        post.comments << record_to_comment_object(record)
      end

      return post
  end

private

  def record_to_post_object(record)
    post = Post.new
    post.id = record['id']
    post.title = record['title']
    post.content = record['content']

    return post
  end

  def record_to_comment_object(record)
    comment = Comment.new
    comment.id = record["comment_id"]
    comment.comment_content = record["comment_content"]
    comment.author = record["author"]

    return comment
  end
end
