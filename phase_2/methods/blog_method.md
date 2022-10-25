Two Tables Design Recipe Template

1. Extract nouns from the user stories or specification
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a blogger
So I can write interesting stuff
I want to write posts having a title.

As a blogger
So I can write interesting stuff
I want to write posts having a content.

As a blogger
So I can let people comment on interesting stuff
I want to allow comments on my posts.

As a blogger
So I can let people comment on interesting stuff
I want the comments to have a content.

As a blogger
So I can let people comment on interesting stuff
I want the author to include their name in comments.

Nouns:

post title, post content, post comments, comment content, comment name

2. Infer the Table Name and Columns
Put the different nouns in this table. Replace the example with your own nouns.

Record	Properties
posts, title, content, comments
comments	content, name

Name of the first table (always plural): posts

Column names: title, content

Name of the second table (always plural): comments

Column names: name, content

3. Decide the column types.
Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# EXAMPLE:

Table: posts
id: SERIAL
title: text
content: text

Table: comments
id: SERIAL
name: text
content: text
post_id: int

4. Decide on The Tables Relationship
Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

To decide on which one, answer these two questions:

Can one [post] have many [comments]? (Yes/No) Yes
Can one [comment] have many [posts]? (Yes/No) No
You'll then be able to say that:

[post] has many [comments]
And on the other side, [comments] belongs to [post]
In that case, the foreign key is in the table [comments]

4. Write the SQL.
-- EXAMPLE
-- file: albums_table.sql

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text
);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  content text,
  author text,
  post_id int,
  constraint fk_posts foreign key(post_id)
    references posts(id)
    on delete cascade
);
5. Create the tables.
psql -h 127.0.0.1 database_name < albums_table.sql