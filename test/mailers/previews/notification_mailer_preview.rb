# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
    def welcome_email
        NotificationMailer.welcome_email(User.new(first: "who", last: "are", email: "you@you.com", password:"helloworld", password_confirmation:"helloworld", username:"helloworld"))
    end
end
