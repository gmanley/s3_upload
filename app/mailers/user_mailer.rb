class UserMailer < ActionMailer::Base

  default from: 'no-reply@example.com'

  def activation_needed_email(user)
    @user = user
    mail(to: user.email, subject: 'Please activate your account.')
  end

  def activation_success_email(user)
    @user = user
    mail(to: user.email, subject: 'Your account is now activated')
  end

  def reset_password_email(user)
    @user = user
    mail(to: user.email, subject: 'Your password reset request')
  end
end