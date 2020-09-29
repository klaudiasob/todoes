# frozen_string_literal: true

require 'swagger_helper'

describe 'Todo' do
  let(:user) { create(:user) }
  let(:Authorization) do
    payload = {
      'jti' => user.jti,
      'sub' => user.id,
      'exp' => Time.now.to_i + 3600
    }
    "Bearer #{JWT.encode(payload, Rails.application.credentials.config[:secret_key_base])}"
  end

  path '/api/v1/users/me/todoes' do
    post 'Create a todo' do
      tags 'Todoes'
      security [basic_auth: []]
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          finished: { type: :boolean }
        },
        required: %w[title description finished]
      }

      response '201', 'todo created' do
        let(:params) { { title: 'Test', description: 'Test description', finished: 'false' } }
        run_test!
      end

      response '400', 'invalid request' do
        let(:params) { { title: nil } }
        run_test!
      end

      response '422', 'invalid params' do
        let(:params) { { title: nil, description: 'Test description', finished: 'false' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/me/todoes' do
    get 'Retrieves all users todoes' do
      tags 'Todoes'
      security [basic_auth: []]
      consumes 'application/json'

      response '200', 'todoes found' do
        run_test!
      end
    end
  end

  path '/api/v1/users/me/todoes/{todo_id}' do
    patch 'Update a todo' do
      tags 'Todoes'
      security [basic_auth: []]
      consumes 'application/json'
      parameter name: :todo_id, in: :path, schema: {
        type: :string,
        properties: {
          todo_id: { type: :integer }
        },
        required: ['todo_id']
      }
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          finished: { type: :boolean }
        }
      }
      let(:todo) { create(:todo, user: user) }
      let(:todo_id) { todo.uuid }

      response '200', 'todo updated' do
        let(:params) { { title: 'Test1' } }
        run_test!
      end

      response '400', 'invalid request' do
        let(:params) { { finished: 'what' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/me/todoes/{todo_id}' do
    delete 'Delete a todo' do
      tags 'Todoes'
      security [basic_auth: []]
      consumes 'application/json'
      parameter name: :todo_id, in: :path, schema: {
        type: :string,
        properties: {
          todo_id: { type: :integer }
        },
        required: ['todo_id']
      }

      let(:todo) { create(:todo, user: user) }
      let(:todo_id) { todo.uuid }

      response '204', 'todo deleted' do
        run_test!
      end
    end
  end
end
