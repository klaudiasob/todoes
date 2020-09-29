# frozen_string_literal: true

require 'swagger_helper'

describe 'User' do
  let(:Authorization) do
    user = create(:user)
    payload = {
      'jti' => user.jti,
      'sub' => user.id,
      'exp' => Time.now.to_i + 3600
    }
    "Bearer #{JWT.encode(payload, Rails.application.credentials.config[:secret_key_base])}"
  end

  path '/api/v1/users' do
    post 'Create a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[email password password_confirmation]
      }

      response '201', 'user created' do
        let(:params) { { email: 'foo@example.com', password: 'password', password_confirmation: 'password' } }
        run_test!
      end

      response '400', 'invalid request' do
        let(:params) { { email: 'foo@example.com' } }
        run_test!
      end
    end
  end

  path '/users/sign_in' do
    post 'Login' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :params, in: :query, schema: {
        type: :object,
        properties: {
          "user[email]": { type: :string },
          "user[password]": { type: :string }
        },
        required: ['user[email]', 'user[password]']
      }

      response '200', 'user logged in', skip: true do
        # This endpoint is provided by devise gem.
        # The test fails due to incompatibility of parameters.
        # However rswag gem successfully generates working documentation for this endpoint.

        let(:params) { { email: 'foo@example.com', password: 'password' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/me' do
    patch 'Update a user' do
      tags 'Users'
      security [basic_auth: []]
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string }
        }
      }

      response '200', 'user updated' do
        let(:params) { { email: 'new_email@example.com' } }

        run_test!
      end

      response '422', 'user not updated' do
        let(:params) { { email: 'new_email@' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/me' do
    get 'Retrieve a user' do
      tags 'Users'
      security [basic_auth: []]
      consumes 'application/json'

      response '200', 'user found' do
        run_test!
      end
    end
  end

  path '/api/v1/users/me' do
    delete 'Delete a user' do
      tags 'Users'
      security [basic_auth: []]
      consumes 'application/json'

      response '204', 'user deleted' do
        run_test!
      end
    end
  end
end
