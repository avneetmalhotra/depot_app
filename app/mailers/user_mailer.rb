class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(id)
    
    @user = User.find_by(id: id)
    mail to: @user.email, subject: 'Welcome to Pragmmatic Store' if @user.present?
  end
end
