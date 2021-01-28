class ApplicationController < ActionController::Base
  include ExceptionLogger::ExceptionLoggable # loades the module
  rescue_from Exception, :with => :log_exception_handler # tells rails to forward the 'Exception' (you can change the type) to the handler of the module

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :ra, :email, :celular, :role_id, :escola_id])
    #devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:nome, :ra, :celular, :email, :password, :password_confirmation, :remember_me) }
  end
end
