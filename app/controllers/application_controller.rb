class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to(root_url)
  end

  protected
  def not_authenticated
    redirect_to(root_path, alert: 'Please login first.')
  end
end