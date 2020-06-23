class UserNotifierMailer < ApplicationMailer
  default :from => "juliusczar.jc@gmail.com"

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_email(user)
    @user = user

    mail(:to => @user.email,
         :subject => "Password Reset",
         :body => "Copy the verification code: #{@user.reset_password_token}")
  end
end
