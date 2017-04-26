require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "moses", email: "moses@example.com")
    @recipe = Recipe.create(name: "vegatable sautee", description: "great vegetable sautee, add vegetable and oil")
  end
  
  test "reject invalid recipe update" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: {recipe: { name: "", description: "some description"}}
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "successfullt edit a recipe" do
    get edit_recipe_path(@recipe)
    assert_template 'recipe/edit'
    update_name = "updated recipe name"
    update_description = "updated recipe description"
    patch recipe_path(@recipe, params: { recipe: { name: updated_name, description: updated_description }})
    assert_redirected_to @recipe
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_description, @recipe.description
    
    #follow_redirect!
  end    
end
