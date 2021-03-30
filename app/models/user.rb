class User < ApplicationRecord
    has_many :products
    
    validates :first, length: { minimum: 2 }, 
    presence: true
    validates :last, length: { minimum: 2 }, 
    presence: true
    validates :email, length: { minimum: 3 }, 
    presence: true
    validates :email,
    format: { with:/\A\S+@.+\.\S+\z/, message: "invalid" },
    uniqueness: { case_sensitive: false },
    length: { minimum: 4, maximum: 254 } 
   
    validates :username, length: {minimum: 3}, uniqueness: true
    has_secure_password
    has_one_attached :image
    acts_as_messageable
end
