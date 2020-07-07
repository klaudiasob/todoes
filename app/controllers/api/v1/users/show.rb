# frozen_string_literal: true

module Api
  module V1
    module Users
      class Show < Base
        desc 'Return a user.'

        get do
          User.find(params[:user_id])
        end
      end
    end
  end
end
