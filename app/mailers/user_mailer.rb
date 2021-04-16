class UserMailer < ApplicationMailer
default from: 'notifications@example.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://buydeis.herokuapp.com/login'
    mail(to: @user.email, subject: 'Welcome to buydeis')
  end
end
