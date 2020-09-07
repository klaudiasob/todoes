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
          user = current_user
          authorize user, :update?
          user.update!({
                         email: params[:email]
                       })
          present user, with: Entities::User
        end
      end
    end
  end
end
