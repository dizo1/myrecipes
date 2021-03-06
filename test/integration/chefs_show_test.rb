require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "moses", email: "moses@example.com",
                        password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "vegatable sautee", description: "great vegetable sautee, add vegetable and oil")
    @recipe2 = @chef.recipes.build(name: "chicken", description: "great chicken")
    #@recipe.save
    @recipe2.save
  end
  
  test "should get chef's sow" do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body
end
end