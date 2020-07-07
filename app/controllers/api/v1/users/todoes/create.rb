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
            Todo.create!({
                           user_id: params[:user_id],
                           title: params[:title],
                           description: params[:description],
                           finished: params[:finished]
                         })
          end
        end
      end
    end
  end
end
