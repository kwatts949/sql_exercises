require_relative './posts'
require_relative './tags'

class TagRepository
  def find_by_post(post_id)
    sql = 'SELECT tags.id, tags.name
            FROM tags 
            JOIN posts_tags ON posts_tags.tag_id = tags.id
            JOIN posts ON posts_tags.post_id = posts.id
          WHERE posts.id = $1;'

      sql_params = [post_id]
    
      result_set = DatabaseConnection.exec_params(sql, sql_params)

      first_record = result_set[0]

      tag = record_to_tag_object(first_record)

      result_set.each do |record|
        p record
        tag.posts << record_to_tag_object(record)
      end
        p tag
      return tag
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