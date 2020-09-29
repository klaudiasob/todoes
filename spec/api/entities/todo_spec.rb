# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Entities::Todo do
  describe 'exposed attributes' do
    subject { described_class.represent(todo).serializable_hash }

    let(:todo) { create(:todo) }

    it 'exposes five attributes' do
      expect(subject.size).to eq 5
    end

    it 'exposes only allowed information' do
      expect(subject).to include(uuid: todo.uuid, title: todo.title, description: todo.description,
                                 finished: todo.finished, created_at: todo.created_at.iso8601)
    end
  end
end
