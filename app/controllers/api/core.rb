# frozen_string_literal: true

module Api
  class Core < Grape::API
    prefix :api
    helpers JwtHelper

    mount Api::V1::Root
  end
end
