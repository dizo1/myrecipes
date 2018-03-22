class Recipe < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true, length: { minimum: 5, maximum: 200 }
    belongs_to :chef
    validates :chef_id, presence: true
    default_scope -> {order(updated_at: :desc)}
    
    mount_uploader :image, ImageUploader
end