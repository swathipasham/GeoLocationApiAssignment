# frozen_string_literal: true

module Api
  module V1
    # Base controller for API
    class BaseController < ActionController::API
      include ActionController::HttpAuthentication::Token::ControllerMethods
      before_action :authenticate!

      # Authenticate the user with token
      def authenticate!
        authenticate_with_http_token do |token, _options|
          render json: { error: 'Unauthorized', code: 401 }, status: :unauthorized unless token == ENV['API_TOKEN']
        end
      end
    end
  end
end
