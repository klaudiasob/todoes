# frozen_string_literal: true

module Api
  class Core < Grape::API
    prefix :api
    helpers JwtHelper
    helpers Pundit
    include ErrorHelper

    mount Api::V1::Root
  end
end
