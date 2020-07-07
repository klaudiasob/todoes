# frozen_string_literal: true

module Api
  module V1
    module Users
      class Update < Base
        desc 'Update a user.'
        params do
          optional :email, type: String, desc: 'Your email.'
        end
        patch do
          user = User.find(params[:user_id])
          user.update!({
                         email: params[:email]
                       })
          user
        end
      end
    end
  end
end
