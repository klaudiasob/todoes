# frozen_string_literal: true

module Api
  module V1
    module Users
      module Todoes
        class Index < Base
          desc 'Returns all users todoes.'

          get do
            todoes = Todo.where(user_id: params[:user_id])

            present todoes, with: Entities::Todo
          end
        end
      end
    end
  end
end
