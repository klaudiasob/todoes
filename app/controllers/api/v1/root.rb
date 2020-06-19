module Api
  module V1
    class Root < Core
      version 'v1', using: :path, vendor: 'todoes'
      format :json

      mount Users::Base
    end
  end
end