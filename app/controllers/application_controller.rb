class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!
    
  protected

  def authenticate_user_except_home_page
    return if controller_name == 'home' && action_name == 'index'
    authenticate_user!
  end
end
