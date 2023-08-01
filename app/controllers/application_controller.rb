class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery prepend: true
    before_action :authenticate_user_except_home_page
    
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
  
  def authenticate_user_except_home_page
    return if controller_name == 'home' && action_name == 'index'
    authenticate_user!
  end
end
