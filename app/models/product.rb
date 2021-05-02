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
    belongs_to :condition
    has_many_attached :images
    acts_as_votable
    validate :validate_images
    has_many :line_items, dependent: :destroy
  def search_data
    {
      name: name,
      date: created_at.year,
      price: price,
      category_id: category_id,
      condition_id: condition_id

    }
    end
   def user_needs_stripe
      if record.first_name == "Evil"
        record.errors.add :base, "This person is evil"
      end
    end
   

private
def validate_images
  return if images.count <= 4

  errors.add(:images, 'You can upload max 4 images')
end
   
end
