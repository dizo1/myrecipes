class IngredientsController < ApplicationController
  
  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 3)
  end
  
  def show
    
  end
  
  
  def new
    
  end
  
  def create
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
end