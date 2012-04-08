class PasswordResetsController < ApplicationController

  def new
  end

  # Reset password form posts here
  def create
    @user = User.first(conditions: {first_name: params[:email]})

    # Sends email to the user containing instructions
    # and a link with random token to reset password.
    @user.deliver_reset_password_instructions! if @user

    # Tell user that instructions have been sent no matter what
    # so as not to indicate whether a user with said email exists or not.
    redirect_to(root_path, notice: 'Instructions have been sent to your email.')
  end

  # Edit password form (reset password link points here).
  def edit
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if !@user
  end

  # Edit password form posts here.
  def update
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if !@user

    # needed to make password confirmation validation work
    @user.password_confirmation = params[:user][:password_confirmation]

    # clear the temporary token and update the password
    if @user.change_password!(params[:user][:password])
      redirect_to(root_path, notice: 'Password was successfully updated.')
    else
      render(action: 'edit')
    end
  end
end