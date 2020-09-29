# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::Todoes::Delete, type: :request do
  describe 'DELETE /api/v1/users/me/todoes/:todo_id' do
    subject do
      delete "/api/v1/users/me/todoes/#{todo_id}", headers: headers
    end

    let!(:user) { create(:user) }
    let(:id) { user.id }
    let!(:todo) { create(:todo, user: user) }
    let(:todo_id) { todo.id }

    context 'unauthenticated' do
      include_context 'unauthenticated'

      it_behaves_like '401'
    end

    context 'authenticated' do
      include_context 'authenticated'

      context 'authorized' do
        include_context 'authorized', TodoPolicy, :delete?
        it 'deletes a todo' do
          expect { subject }.to change(Todo, :count).by(-1)
        end

        it 'returns status code 200' do
          subject
          expect(response).to have_http_status(:success)
        end
      end

      context 'unauthorized' do
        include_context 'unauthorized', TodoPolicy, :delete?

        it_behaves_like '403'
      end
    end
  end
end
