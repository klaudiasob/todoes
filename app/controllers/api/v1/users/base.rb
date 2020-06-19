module Api
  module V1
    module Users
      class Base < Root
        resource :users do
          mount Create

          route_param :id do
            mount Show
            mount Update
            mount Delete
          end
        end
      end
    end
  end
end