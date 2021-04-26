# app/controllers/notifications_controller.rb
class NotificationsController < ApplicationController
    before_action :set_notifications
  
    def index
        @notifications = Notification.where(recipient: current_user)
    end

    def mark_as_read
        @notifications = Notification.where(recipient: current_user).unread
        @notification.update_all(read_at: Time.zone.now)
        render json: {success: true}
    end
end