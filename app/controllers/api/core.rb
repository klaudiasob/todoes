module Api
  class Core < Grape::API
    prefix :api

    mount Api::V1::Root
  end
end