class Product < ApplicationRecord
    searchkick 
    validates :name, length: { minimum: 2 }, 
    presence: true
    validates :description, length: { minimum: 20 }, 
    presence: true
    validates :price, 
    presence: true
    belongs_to :user
    belongs_to :category
    has_many_attached :images
    acts_as_votable
    has_many :line_items, dependent: :destroy
  
   
   
end
