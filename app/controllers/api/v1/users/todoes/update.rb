# frozen_string_literal: true

module Api
  module V1
    module Users
      module Todoes
        class Update < Base
          desc 'Update a todo.'
          params do
            optional :title, type: String, desc: 'Title'
            optional :description, type: String, desc: 'Description'
            optional :finished, type: Boolean, desc: 'Status'
          end

          patch do
            todo = Todo.find_by(uuid: params[:todo_id])
            authorize todo, :update?

            todo.assign_attributes(params.except(:todo_id))
            todo.save!
            present todo, with: Entities::Todo
          end
        end
      end
    end
  end
end
