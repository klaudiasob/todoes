# frozen_string_literal: true

module Api
  module V1
    module Users
      class Show < Base
        desc 'Return a user.'

        get do
          user = current_user
          authorize user, :show?
          present user, with: Entities::User
        end
      end
    end
  end
end
