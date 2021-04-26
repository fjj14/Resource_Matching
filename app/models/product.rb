class Product < ApplicationRecord
    searchkick
    before_destroy :not_referenced_by_any_line_items
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
    has_many :line_items
    
    private
    def not_referenced_by_any_line_items
        unless line_items.empty? 
            errors.add(:base, "line_items present")
            throw :abort
        end
    end
end
