module Api
  module V1
    module Users
      class Update < Base
        desc 'Update a user.'
        params do
          optional :email, type: String, desc: 'Your email.'
        end
        patch do
          user = User.find(params[:id])
          user.update!({
                           email: params[:email],
                       })
          user
        end
      end
    end
  end
end