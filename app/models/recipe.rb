class Recipe < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true, length: { minimum: 5, maximum: 200 }
    belongs_to :chef
    validates :chef_id, presence: true
    default_scope -> {order(updated_at: :desc)}
    
    mount_uploader :image, ImageUploader
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients
    has_many :comments, dependent: :destroy
end