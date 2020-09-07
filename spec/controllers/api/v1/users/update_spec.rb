# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::Update, type: :request do
  describe 'PATCH /api/v1/users/me' do
    subject do
      patch '/api/v1/users/me', params: params, headers: headers
    end

    let(:user) { User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password') }
    let(:params) do
      {
        email: 'test2@example.com'
      }
    end

    let(:response_body) { Entities::User.represent(user.reload).serializable_hash.with_indifferent_access }

    context 'unauthenticated' do
      include_context 'unauthenticated'

      it_behaves_like '401'
    end

    context 'authenticated' do
      include_context 'authenticated'
      context 'authorized' do
        include_context 'authorized', UserPolicy, :update?

        it 'updates a user' do
          expect { subject }.to change { user.reload.email }.from(user.email).to(params[:email])
        end

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
        include_context 'unauthorized', UserPolicy, :update?

        it_behaves_like '403'
      end
    end
  end
end
