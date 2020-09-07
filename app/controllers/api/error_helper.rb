# frozen_string_literal: true

module Api
  module ErrorHelper
    extend ActiveSupport::Concern

    included do
      rescue_from Pundit::NotAuthorizedError do |e|
        error!({ message: e.message }, 403)
      end
    end
  end
end
