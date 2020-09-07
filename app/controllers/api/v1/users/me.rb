# frozen_string_literal: true

module Api
  module V1
    module Users
      class Me < Base
        desc 'Returns current user.'

        get do
          user = current_user
          authorize user, :me?
          present user, with: Entities::User
        end
      end
    end
  end
end
