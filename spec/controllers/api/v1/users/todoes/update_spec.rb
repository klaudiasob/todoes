# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::Todoes::Update, type: :request do
  describe 'PATCH /api/v1/users/me/todoes/:todo_id' do
    subject do
      patch "/api/v1/users/me/todoes/#{todo_id}", params: params, headers: headers
    end

    let(:user) { create(:user) }
    let(:id) { user.id }
    let(:todo) { create(:todo, :not_finished, user: user) }
    let(:todo_id) { todo.uuid }
    let(:params) do
      {
        finished: true
      }
    end
    let(:response_body) { Entities::Todo.represent(todo.reload).serializable_hash.with_indifferent_access }

    context 'unauthenticated' do
      include_context 'unauthenticated'

      it_behaves_like '401'
    end

    context 'authenticated' do
      include_context 'authenticated'
      context 'authorized' do
        include_context 'authorized', TodoPolicy, :update?

        it 'updates a todo' do
          expect { subject }.to change { todo.reload.finished }.from(todo.finished).to(params[:finished])
        end

        it 'returns status code 200' do
          subject
          expect(response).to have_http_status(:success)
        end

        it 'returns a todo' do
          subject
          expect(JSON.parse(response.body)).to eq(response_body)
        end
      end

      context 'unauthorized' do
        include_context 'unauthorized', TodoPolicy, :update?

        it_behaves_like '403'
      end
    end
  end
end
