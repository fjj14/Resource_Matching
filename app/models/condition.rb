class Condition < ApplicationRecord
    has_many :products
    validates :name, length: { minimum: 2 }, 
    presence: true
end
