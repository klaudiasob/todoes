# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::Delete, type: :request do
  describe 'DELETE /api/v1/users/:id' do
    subject do
      delete "/api/v1/users/#{id}", headers: headers
    end

    let!(:user) { User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password') }
    let(:id) { user.id }

    context 'unauthenticated' do
      include_context 'unauthenticated'

      it_behaves_like '401'
    end

    context 'authenticated' do
      include_context 'authenticated'

      it 'deletes a user' do
        expect { subject }.to change(User, :count).by(-1)
      end

      it 'returns status code 200' do
        subject
        expect(response).to have_http_status(:success)
      end
    end
  end
end
