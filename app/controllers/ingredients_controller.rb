class IngredientsController < ApplicationController
    before_action :set_ingred, only: [:edit, :show, :update]
    before_action :require_admin, except: [:show, :index]
  
  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 3)
  end
  
  def show
    @ingredient_recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 3)
  end
  
  
  def new
    @ingredient = Ingredient.new
  end
  
  def create
    @ingredient = Ingredient.new(ingredient_params)
        if @ingredient.save
            flash[:success] = "Ingredient Created Successfully"
            redirect_to ingredient_path(@ingredient)
        else
            render 'new'
        end
  end
  
  def edit
    
  end
  
  def update
      if @ingredient.update(ingredient_params)
          flash[:success] = "Ingredient updated successfully"
          redirect_to @ingredient
      else
          render 'edit'
      end
    
  end
  
end

private

    def require_admin
        if !logged_in? || (logged_in? and !current_chef.admin?)
        flash[:danger] = "ONLY ADMIN USERS CAN DO THAT!"
            redirect_to ingredients_path
        end
    end

    def set_ingred
        @ingredient = Ingredient.find(params[:id])
    end
    
    def ingredient_params
        params.require(:ingredient).permit(:name)
    end