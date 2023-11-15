class ApplicationController < ActionController::Base
  around_action :switch_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name email avatar password password_confirmation current_password])
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  rescue StandardError => e
    puts e.message
  ensure
    I18n.with_locale(I18n.default_locale, &action)
  end
end
