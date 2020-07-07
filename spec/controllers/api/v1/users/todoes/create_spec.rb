# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::Todoes::Create, type: :request do
  describe 'POST /api/v1/users/:id/todoes' do
    subject do
      post "/api/v1/users/#{id}/todoes", params: params, headers: headers
    end

    let(:user) { User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password') }
    let(:id) { user.id }
    let(:params) do
      {
        title: 'Test',
        description: 'Test description',
        finished: 'false'
      }
    end

    context 'unauthenticated' do
      include_context 'unauthenticated'

      it_behaves_like '401'
    end

    context 'authenticated' do
      include_context 'authenticated'

      context 'when params are valid' do
        it 'creates a todo' do
          expect { subject }.to change(Todo, :count).by(1)
        end
      end

      context 'when params are invalid' do
        let(:params) do
          {
            title: nil,
            description: 'Test description',
            finished: 'false'
          }
        end

        it 'raises an error' do
          expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end
end
