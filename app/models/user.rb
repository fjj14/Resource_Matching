class User < ApplicationRecord
    validates :name, length: { minimum: 3 }, 
    presence: true
    validates :email, length: { minimum: 3 }, 
    presence: true
    validates :email, uniqueness: true
end
