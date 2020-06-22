# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::Create, type: :request do
  describe 'POST /api/v1/users' do
    subject do
      post '/api/v1/users', params: params
    end

    context 'when params are valid' do
      let(:params) do
        {
          email: 'test@example.com',
          password: 'password',
          password_confirmation: 'password'
        }
      end

      it 'creates a user' do
        expect { subject }.to change(User, :count).by(1)
      end
    end

    context 'when params are invalid' do
      let(:params) do
        {
          email: 'test@example.com',
          password: 'password',
          password_confirmation: 'pasword'
        }
      end

      it 'raises an error' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
