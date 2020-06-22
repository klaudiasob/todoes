module Api
  module JwtHelper
    extend ::Grape::API::Helpers

    def unauthenticated_error
      error!({message: 'Unauthenticated'}, 401)
    end

    def authenticate!
      unauthenticated_error unless current_user
    end

    def current_user
      token = bearer_token
      return if token.nil?

      decoded_token = decode(token)
      return if Time.at(decoded_token[:exp]) < Time.now

      User.find_by(id: decoded_token[:sub])
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.credentials.config[:secret_key_base])[0]
      HashWithIndifferentAccess.new body
    end

    def bearer_token
      pattern = /^Bearer /
      header  = headers['Authorization']
      header.gsub(pattern, '') if header && header.match(pattern)
    end
  end
end