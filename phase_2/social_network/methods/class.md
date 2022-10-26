# **{{TABLE NAME}} Model and Repository Classes Design Recipe**

*Copy this recipe template to design and implement Model and Repository classes for a database table.*

## **2. Create Test SQL seeds**

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

- `- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)
-- Write your SQL seed here.
-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE users RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users (username, email_address) VALUES ('David5', 'david@five.com');
INSERT INTO users (username, email_address) VALUES ('Ann4', 'annafour@mail.com');

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

TRUNCATE TABLE posts RESTART IDENTITY;

INSERT INTO posts (title, content, views, user_id) VALUES ('Cats', 'Cat facts', '1', '1');
INSERT INTO posts (title, content, views, user_id) VALUES ('Dogs', 'Dog facts', '15', '2');
INSERT INTO posts (title, content, views, user_id) VALUES ('Interesting!', 'Telegraph poles', '0', '1');
INSERT INTO posts (title, content, views, user_id) VALUES ('Recipes', 'Cake', '30', '2');


`psql -h 127.0.0.1 social_network < seeds_users.sql`

## **3. Define the class names**

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

`# EXAMPLE
# Table name: users

# Model class
# (in lib/student.rb)
class User
end

# Repository class
# (in lib/student_repository.rb)
class UserRepository
end`

## **4. Implement the Model class**

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

class User
  attr_accessor :id, :username, :email_address
end


class Post
  attr_accessor :id, :title, :content, :views, :user_id
end


## **5. Define the Repository Class interface**

class UserRepository
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students;

    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students WHERE id = $1;

    # Returns a single Student object.
  end

  def create
  end

  def delete
  end
end

class PostRepository
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students;

    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students WHERE id = $1;

    # Returns a single Student object.
  end

  def create
  end

  def delete
  end
end`

## **6. Write Test Examples**

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

`# EXAMPLES

# 1
# Get all students

repo = UserRepository.new

users = repo.all

users.length # => 2
users.first.username # => 'david5'
users.last.email_address #=> 'annafour@mail.com'

# 2
# Get a single student

repo = PostRepository.new

post = repo.find(3)

post.id # =>  3
post.title # =>  'Interesting!'
post.contents # => "Telegraph poles"
post.views # =>  '0'
post.user_id # => '1'

# Creates a new user

repo = UserRepository.new

new_user = User.new
new_user.name = 'Samatha'
new_user.email_address = 'sam@gmail.com'

user = repo.create(new_user)

all_users = repo.all

expect(all_users).to include(
  have attributes(
    name: new_user.name,
    email_address: new_user.email_address
  )
)

# Deletes a post

repo = PostRepository.new

repo.delete(3)

posts = repo.all
expect(posts.length).to eq 3
expect(posts.last.title).to eq 'Recipes'

## **7. Reload the SQL seeds before each test run**

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

`# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_users_table
  seed_sql = File.read('spec/seeds_users.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'users' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_users_table
  end

  # (your tests will go here).
end`

## **8. Test-drive and implement the Repository class behaviour**

*After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.*