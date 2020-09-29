# frozen_string_literal: true

module Api
  module ErrorHelper
    extend ActiveSupport::Concern

    included do
      rescue_from Pundit::NotAuthorizedError do |e|
        error!({ message: e.message }, 403)
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        error!({ message: e.message }, 422)
      end
    end
  end
end
