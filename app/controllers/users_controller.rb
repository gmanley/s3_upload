class UsersController < ApplicationController
  respond_to :html

  def show
    @user = User.find_by_slug(params[:id])
    authorize!(:show, User)

    respond_with(@user)
  end

  def new
    @user = User.new(params[:user])
    authorize!(:new, User)

    respond_with(@user)
  end

  def edit
    @user = User.find_by_slug(params[:id])
    authorize!(:edit, @user)

    respond_with(@user)
  end

  def create
    @user = User.new(params[:user])
    authorize!(:create, @user)

    @user.save
    respond_with(@user)
  end

  def update
    @user = User.find_by_slug(params[:id])
    authorize!(:update, @user)

    @user.update_attributes(params[:user])
    respond_with(@user)
  end

  # TODO: Possibile to make this REST? Worth it?
  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      redirect_to(login_path, notice: 'User was successfully activated.')
    else
      not_authenticated
    end
  end
end