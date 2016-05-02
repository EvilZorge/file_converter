class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def default_url_options(options={})
    { locale: I18n.locale }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)        << [:name, :lastname]
    devise_parameter_sanitizer.for(:account_update) << [:name, :lastname]
  end

  def set_locale
    I18n.locale = params[:locale] || "en"
  end
end
