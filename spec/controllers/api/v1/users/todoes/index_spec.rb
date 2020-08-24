# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Users::Todoes::Index, type: :request do
  describe 'GET /api/v1/users/:id/todoes' do
    subject do
      get "/api/v1/users/#{id}/todoes", headers: headers
    end

    let(:user) { create(:user) }
    let(:id) { user.id }
    let(:response_body) { Entities::Todo.represent(Todo.where(user_id: user.id)).map { |todo| todo.serializable_hash.with_indifferent_access } }

    context 'unauthenticated' do
      include_context 'unauthenticated'

      it_behaves_like '401'
    end

    context 'authenticated' do
      include_context 'authenticated'

      it 'returns todoes' do
        create_list(:todo, 3)
        create_list(:todo, 3, user: user)
        subject
        expect(JSON.parse(response.body)).to eq(response_body)
      end
    end
  end
end
