# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::Me, type: :request do
  describe 'GET /api/v1/users/me' do
    subject do
      get '/api/v1/users/me', headers: headers
    end

    let(:user) { User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password') }

    let(:response_body) { Entities::User.represent(user).serializable_hash.with_indifferent_access }

    context 'unauthenticated' do
      include_context 'unauthenticated'

      it_behaves_like '401'
    end

    context 'authenticated' do
      include_context 'authenticated'

      context 'authorized' do
        include_context 'authorized', UserPolicy, :me?

        it 'returns a user' do
          subject
          expect(JSON.parse(response.body)).to eq(response_body)
        end

        it 'returns status code 200' do
          subject
          expect(response).to have_http_status(:success)
        end
      end

      context 'unauthorized' do
        include_context 'unauthorized', UserPolicy, :me?

        it_behaves_like '403'
      end
    end
  end
end
