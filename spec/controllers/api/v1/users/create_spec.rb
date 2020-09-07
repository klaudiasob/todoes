# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::Create, type: :request do
  describe 'POST /api/v1/users' do
    subject do
      post '/api/v1/users', params: params
    end

    let(:response_body) { Entities::User.represent(User.last).serializable_hash.with_indifferent_access }
    let(:params) do
      {
          email: 'test@example.com',
          password: 'password',
          password_confirmation: 'password'
      }
    end

    context 'when params are valid' do
      context 'authorized' do
        include_context 'authorized', UserPolicy, :create?
        it 'creates a user' do
          expect { subject }.to change(User, :count).by(1)
        end

        it 'returns a user' do
          subject
          expect(JSON.parse(response.body)).to eq(response_body)
        end
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

    context 'unauthorized' do
      include_context 'unauthorized', UserPolicy, :create?

      it_behaves_like '403'
    end
  end
end
