require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'

DatabaseConnection.connect('recipes_directory')

sql = 'SELECT id, name FROM recipes;'
result = DatabaseConnection.exec_params(sql, [])

result.each do |record|
  p record
end

recipe_repository = RecipeRepository.new

recipe = recipe_repository.find(2)
  puts recipe.name
  puts recipe.cooking_time


