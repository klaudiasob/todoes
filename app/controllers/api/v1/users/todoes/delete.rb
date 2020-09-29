# frozen_string_literal: true

module Api
  module V1
    module Users
      module Todoes
        class Delete < Base
          desc 'Delete a todo.'

          delete do
            todo = Todo.find_by(uuid: params[:todo_id])
            authorize todo, :delete?
            todo.destroy!
            header :no_content
          end
        end
      end
    end
  end
end
