class Rating < ApplicationRecord
    belongs_to :user
    validates_inclusion_of :rating_number, :in => 1..5, :message => 'The rating must be between 1 and 5'
    validates :comment, 
    presence: true

  

end
