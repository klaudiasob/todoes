# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::Update, type: :request do
  describe 'PATCH /api/v1/users/:id' do
    subject do
      patch "/api/v1/users/#{id}", params: params, headers: headers
    end

    let(:user) { User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password') }
    let(:id) { user.id }
    let(:params) do
      {
        email: 'test2@example.com'
      }
    end

    context 'unauthenticated' do
      include_context 'unauthenticated'

      it_behaves_like '401'
    end

    context 'authenticated' do
      include_context 'authenticated'

      it 'updates a user' do
        expect { subject }.to change { user.reload.email }.from(user.email).to(params[:email])
      end

      it 'returns status code 200' do
        subject
        expect(response).to have_http_status(:success)
      end
    end
  end
end
