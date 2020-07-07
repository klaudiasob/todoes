# frozen_string_literal: true

module Api
  module V1
    module Users
      module Todoes
        class Delete < Base
          desc 'Delete a todo.'

          delete do
            Todo.find(params[:todo_id]).destroy!
          end
        end
      end
    end
  end
end
