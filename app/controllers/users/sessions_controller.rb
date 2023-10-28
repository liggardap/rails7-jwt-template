# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include ApiException::Handler
  protect_from_forgery with: :null_session
  respond_to :json
  attr_reader :resource

  def create
    @resource = User.find_by_username!(login_params[:username])
    @resource.errors.add(:base, :login_error) unless @resource.try(:valid_password?, login_params[:password])
    return log_in_error unless @resource.errors.blank?

    sign_in(:user, @resource)
    log_in_success
  end

  private

  def log_in_success
    render_json(data: resource,
                serializer: 'Users::Detail',
                message: 'Login Success')
  end

  def log_in_error
    raise Unauthorized
  end

  def respond_to_on_destroy
    current_user ? log_out_success : log_out_failure
  end

  def log_out_success
    render_json(data: @resource,
                serializer: 'Users::Detail',
                message: 'Logout Success')
  end

  def log_out_failure
    raise LogoutError
  end

  def login_params
    params.require(:user).permit(:username, :password)
  end
end
