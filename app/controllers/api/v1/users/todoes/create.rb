# frozen_string_literal: true

module Api
  module V1
    module Users
      module Todoes
        class Create < Base
          desc 'Creates a todo.'
          params do
            requires :title, type: String, desc: 'Title'
            requires :description, type: String, desc: 'Description'
            requires :finished, type: Boolean, desc: 'Status'
          end

          post do
            authorize Todo, :create?

            todo = Todo.create!({
                                  user_id: current_user.id,
                                  title: params[:title],
                                  description: params[:description],
                                  finished: params[:finished]
                                })
            present todo, with: Entities::Todo
          end
        end
      end
    end
  end
end
