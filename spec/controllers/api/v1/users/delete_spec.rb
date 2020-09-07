# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::Delete, type: :request do
  describe 'DELETE /api/v1/users/me' do
    subject do
      delete '/api/v1/users/me', headers: headers
    end

    let!(:user) { User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password') }

    context 'unauthenticated' do
      include_context 'unauthenticated'

      it_behaves_like '401'
    end

    context 'authenticated' do
      include_context 'authenticated'

      context 'authorized' do
        include_context 'authorized', UserPolicy, :delete?
        it 'deletes a user' do
          expect { subject }.to change(User, :count).by(-1)
        end

        it 'returns status code 200' do
          subject
          expect(response).to have_http_status(:success)
        end
      end

      context 'unauthorized' do
        include_context 'unauthorized', UserPolicy, :delete?

        it_behaves_like '403'
      end
    end
  end
end
