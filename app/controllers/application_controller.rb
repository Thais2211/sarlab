class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :ra, :email, :celular, :role_id, :escola_id])
    #devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:nome, :ra, :celular, :email, :password, :password_confirmation, :remember_me) }
  end
end
