module Api
  module V1
    module Users
      class Delete < Base
        desc 'Delete a user.'

        delete do
          User.find(params[:id]).destroy!
        end
      end
    end
  end
end
