class Product < ApplicationRecord
    validates :name, length: { minimum: 2 }, 
    presence: true
    validates :description, length: { minimum: 20 }, 
    presence: true
    validates :price, 
    presence: true
    belongs_to :user
    has_one_attached :image
end
