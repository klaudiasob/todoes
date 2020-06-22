# frozen_string_literal: true

module Api
  module V1
    module Users
      class Show < Base
        desc 'Return a user.'
        params do
          requires :id, type: Integer, desc: 'User ID.'
        end

        get do
          User.find(params[:id])
        end
      end
    end
  end
end
