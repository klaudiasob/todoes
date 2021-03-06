# frozen_string_literal: true

module Api
  module V1
    module Users
      class Create < Base
        desc 'Create a user.'
        params do
          requires :email, type: String, desc: 'Your email.'
          requires :password, type: String, desc: 'Your password.'
          requires :password_confirmation, type: String, desc: 'Your password confirmation.'
        end

        post do
          authorize User, :create?
          user = User.create!({
                                email: params[:email],
                                password: params[:password],
                                password_confirmation: params[:password_confirmation]
                              })
          present user, with: Entities::User
        end
      end
    end
  end
end
