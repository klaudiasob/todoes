# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::Todoes::Update, type: :request do
  describe 'PATCH /api/v1/users/:id/todoes/:todo_id' do
    subject do
      patch "/api/v1/users/#{id}/todoes/#{todo_id}", params: params, headers: headers
    end

    let(:user) { create(:user) }
    let(:id) { user.id }
    let(:todo) { create(:todo, :not_finished) }
    let(:todo_id) { todo.id }
    let(:params) do
      {
        finished: true
      }
    end

    context 'unauthenticated' do
      include_context 'unauthenticated'

      it_behaves_like '401'
    end

    context 'authenticated' do
      include_context 'authenticated'

      it 'updates a todo' do
        expect { subject }.to change { todo.reload.finished }.from(todo.finished).to(params[:finished])
      end

      it 'returns status code 200' do
        subject
        expect(response).to have_http_status(:success)
      end
    end
  end
end
