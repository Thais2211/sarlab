class ApplicationController < ActionController::Base

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome, :ra, :email, :celular])
  end
end
