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
    validate :validate_user_has_stripe_id
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

 
   

private
def validate_images
  return if images.count <= 4
  errors.add(:images, 'You can upload max 4 images')
end
   
def validate_user_has_stripe_id
  if user.stripe_user_id == nil
    errors.add(:base, "You can't create a product without a stripe id")
  end
end
end
