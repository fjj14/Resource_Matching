class Rating < ApplicationRecord
    belongs_to :user
    validates_inclusion_of :rating_number, :in => 1..5, :message => 'The rating must be between 1 and 5'
    validates :comment, 
    presence: true

    #notification
    after_create :create_notifications

    private


    def create_notifications
        if current_user
            Notification.create(recipient: current_user, actor: self.user,
            action: 'reveiwed ', notifiable: self)
        end
    end

end
