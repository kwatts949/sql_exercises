TRUNCATE TABLE posts RESTART IDENTITY CASCADE;
TRUNCATE TABLE comments RESTART IDENTITY; -- replace with your own table name.

INSERT INTO posts (title, content) VALUES ('April', 'Holidays');
INSERT INTO posts (title, content) VALUES ('May', 'Weather');

INSERT INTO comments (comment_content, author, post_id) VALUES ('Yess!', 'David', 1);
INSERT INTO comments (comment_content, author, post_id) VALUES ('Agreed','David', 2);
INSERT INTO comments (comment_content, author, post_id) VALUES ('Why?', 'Slyvie', '1');
INSERT INTO comments (comment_content, author, post_id) VALUES ('How,', 'Marina', '1');
INSERT INTO comments (comment_content, author, post_id) VALUES ('Noo!', 'Amy', '2');