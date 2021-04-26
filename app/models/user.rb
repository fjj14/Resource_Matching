class User < ApplicationRecord
    has_many :products
    has_many :ratings
    has_many :active_relationships, class_name:  "Relationship",
    foreign_key: "follower_id",
    dependent:   :destroy


    has_many :following, through: :active_relationships, source: :followed
    has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
    has_many :followers, through: :passive_relationships, source: :follower
    belongs_to :cart, optional: true 
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
    acts_as_voter

    def follow(other_user)
       following << other_user
    end

    def unfollow(other_user)
        following.delete(other_user)
    end
    def following?(other_user)
        following.include?(other_user)
    end
    def send_welcome 
        NotificationMailer.welcome_email(self)
    end
    def bought_from_me?(other_user)
        @prods = self.products.where.not(buyer_id: nil)
        @prods.each do |prod|
            if User.find(prod.buyer_id) == other_user
                return true
            end
        end
        false
    end
    def rated_already(other_user)
        @rat = self.ratings
        @rat.each do |rating|
            if User.find(rating.reviewer_id) == other_user
                return true 
            end
        end
        return false
    end

    def feed(products)
        products = products.where(buyer_id: nil).order('created_at DESC')
        @followingProducts =[]
        products.each do |product|
            if following.include?(product.user)
                @followingProducts[@followingProducts.length] = product
            end
        end
        @nonfollower = products - @followingProducts
        finalList = @followingProducts + @nonfollower
        return finalList
    end
end
