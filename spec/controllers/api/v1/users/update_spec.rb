require 'rails_helper'

RSpec.describe Api::V1::Users::Update, :type => :request do
  describe 'PATCH /api/v1/users/:id' do

    subject do
      patch "/api/v1/users/#{id}", params: params
    end

    let(:user) { User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password') }
    let(:id) { user.id }
    let(:params) do
    {
        email: 'test2@example.com'
    }
    end

    let(:response_body) do
      {
          "id" => user.id,
          "email" => params[:email],
          "created_at" => user.created_at.strftime('%FT%H:%M:%S.%3NZ'),
          "updated_at" => user.updated_at.strftime('%FT%H:%M:%S.%3NZ')
      }
    end

    it 'updates a user' do
      expect { subject }.to change { user.reload.email }.from(user.email).to(params[:email])
    end

    it 'returns status code 200' do
      subject
      expect(response).to have_http_status(:success)
    end
  end

end