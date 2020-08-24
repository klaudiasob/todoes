# frozen_string_literal: true

module Api
  module V1
    module Users
      class Delete < Base
        desc 'Delete a user.'

        delete do
          User.find(params[:user_id]).destroy!
          head :no_content
        end
      end
    end
  end
end
