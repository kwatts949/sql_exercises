INSERT INTO posts (title) VALUES ('SQL Basics');

INSERT INTO tags (name) VALUES ('sql');

INSERT INTO posts_tags (post_id, tag_id) VALUES (7, 5);

SELECT posts.id, posts.title
  FROM posts 
    JOIN posts_tags ON posts_tags.post_id = posts.id
    JOIN tags ON posts_tags.tag_id = tags.id
  WHERE tags.id = 5;