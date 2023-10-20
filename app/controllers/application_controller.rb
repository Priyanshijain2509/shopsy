# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
# to permit additional params other than provided by devise gem
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [
        :first_name,
        :last_name,
        :role,
        :contact_number,
        :address,
        :state,
        :pin_code
      ]
    )
    devise_parameter_sanitizer.permit(
      :account_update, keys: [
        :email,
        :password,
        :password_confirmation,
        :contact_number,
        :address,
        :state,
        :pin_code
      ]
    )
  end

end
