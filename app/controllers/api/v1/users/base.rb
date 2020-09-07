# frozen_string_literal: true

module Api
  module V1
    module Users
      class Base < Root
        resource :users do
          mount Create

          before { authenticate! }

          namespace :me do
            mount Me
            mount Update
            mount Delete

            namespace :todoes do
              mount Todoes::Index
              mount Todoes::Create
              route_param :todo_id do
                mount Todoes::Update
                mount Todoes::Delete
              end
            end
          end
        end
      end
    end
  end
end
