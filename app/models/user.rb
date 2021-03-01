class User < ApplicationRecord
    validates :name, length: { minimum: 3 }, 
    presence: true
    validates :email, length: { minimum: 3 }, 
    presence: true
    validates :email, uniqueness: true
    validates :password, length: {minimum: 8}, presence: true;
    #validates :username, length: {minimum: 3}, uniqueness: true; 
end
