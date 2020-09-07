# frozen_string_literal: true

module Api
  module V1
    module Users
      class Delete < Base
        desc 'Delete a user.'

        delete do
          user = current_user
          authorize user, :delete?
          user.destroy!
          header :no_content
        end
      end
    end
  end
end
