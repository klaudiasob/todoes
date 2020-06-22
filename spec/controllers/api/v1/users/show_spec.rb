require 'rails_helper'

RSpec.describe Api::V1::Users::Show, :type => :request do
  describe 'GET /api/v1/users/:id' do

    subject do
      get "/api/v1/users/#{id}", headers: headers
    end

    let(:user) { User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password') }
    let(:id) { user.id }

    let(:response_body) do
      {
          "id" => user.id,
          "email" => user.email,
          "created_at" => user.created_at.strftime('%FT%H:%M:%S.%3NZ'),
          "updated_at" => user.updated_at.strftime('%FT%H:%M:%S.%3NZ')
      }
    end

    context 'unauthenticated' do
      include_context 'unauthenticated'

      it_behaves_like '401'
    end

    context 'authenticated' do
      include_context 'authenticated'

      it 'returns a user' do
        subject
        expect(JSON.parse(response.body)).to eq(response_body)
      end

      it 'returns status code 200' do
        subject
        expect(response).to have_http_status(:success)
      end
    end
  end

end