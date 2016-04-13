class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection

  require 'auth_token'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  protected

    def authenticate_jwt
      begin
        payload, header = AuthToken.valid?(request.headers['Authorization'].split(' ').last)
        @current_user = User.find_by(id: payload['user_id'])
        if @current_user.nil?
          head :unauthorized
        end
      rescue
        head :unauthorized
      end
    end
end
