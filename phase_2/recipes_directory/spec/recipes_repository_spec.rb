require 'recipe_repository'

RSpec.describe RecipeRepository do

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

  before(:each) do 
    reset_recipes_table
  end

  it 'returns a list of all the recipes' do
    repo = RecipeRepository.new

    recipes = repo.all

    expect(recipes.length).to eq 2
    expect(recipes.first.id ).to eq "1"
    expect(recipes.first.name).to eq "Pancakes"
  end

  it 'finds a single record' do
    repo = RecipeRepository.new

    recipes = repo.find(2)

    expect(recipes.id).to eq "2"
    expect(recipes.name).to eq 'Pasta'
    expect(recipes.cooking_time).to eq '5'
  end
end