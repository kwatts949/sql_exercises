require_relative './posts'
require_relative './tags'

class PostRepository
  def find_with_tags(tag_id)
    sql = 'SELECT posts.id, posts.title
            FROM posts 
            JOIN posts_tags ON posts_tags.post_id = posts.id
            JOIN tags ON posts_tags.tag_id = tags.id
          WHERE tags.id = $1;'

      sql_params = [tag_id]
    
      result_set = DatabaseConnection.exec_params(sql, sql_params)

      first_record = result_set[0]

      post = record_to_post_object(first_record)

      result_set.each do |record|
        post.tags << record_to_post_object(record)
      end

      return post
  end

private

  def record_to_post_object(record)
    post = Post.new
    post.id = record['id']
    post.title = record['title']

    return post
  end

  def record_to_tag_object(record)
    tag = Tag.new
    tag.id = record["id"]
    tag.name = record["name"]

    return tag
  end
end