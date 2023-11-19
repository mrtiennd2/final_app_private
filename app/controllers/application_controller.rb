class ApplicationController < ActionController::Base
  layout :set_layout

  around_action :switch_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name avatar])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[first_name last_name email avatar password password_confirmation
                                               current_password])
  end

  def set_layout
    if current_user&.is_admin
      'admin'
    else
      'application'
    end
  end

  def switch_locale(&action)
    default_locale = I18n.default_locale
    locale = params[:locale] || default_locale
    if I18n.available_locales.include?(locale.to_sym)
      I18n.default_locale = locale
      I18n.with_locale(locale, &action)
    else
      I18n.with_locale(default_locale, &action)
    end
  end
end
