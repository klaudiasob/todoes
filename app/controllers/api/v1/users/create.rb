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
          User.create!({
                           email: params[:email],
                           password: params[:password],
                           password_confirmation: params[:password_confirmation]
                       })
        end
      end
    end
  end
end