TRUNCATE TABLE posts RESTART IDENTITY;

INSERT INTO posts (title, content, views, user_id) VALUES ('Cats', 'Cat facts', '1', '1');
INSERT INTO posts (title, content, views, user_id) VALUES ('Dogs', 'Dog facts', '15', '2');
INSERT INTO posts (title, content, views, user_id) VALUES ('Interesting!', 'Telegraph poles', '0', '1');
INSERT INTO posts (title, content, views, user_id) VALUES ('Recipes', 'Cake', '30', '2');