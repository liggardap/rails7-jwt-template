# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include ApiException::Handler
  protect_from_forgery with: :null_session
  respond_to :json
  

  def create
    build_resource(sign_up_params)
    sign_up(:user, resource) if resource.save!

    register_success
  end

  private

  def register_success
    render_json(data: resource,
                serializer: 'Users::Detail',
                message: 'Register Success')
  end

  def sign_up_params
    params.require(:user)
          .permit(:username, :email, :password, :password_confirmation, :phone, :type)
  end
end
