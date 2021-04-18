class UserMailer < ApplicationMailer
default from: 'buydeisco@gmail.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://buydeis.herokuapp.com/login'
    mail(to: @user.email, subject: 'Welcome to buydeis')
  end
end
