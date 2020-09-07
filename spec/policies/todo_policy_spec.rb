# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TodoPolicy do
  subject { described_class }

  permissions :update? do
    context 'user is not todo owner' do
      it 'denies access to update todo' do
        expect(subject).not_to permit(User.new, Todo.new)
      end
    end

    context 'user is todo owner' do
      it 'grants access to update todo' do
        user = build(:user)
        todo = build(:todo, user: user)
        expect(subject).to permit(user, todo)
      end
    end
  end

  permissions :create? do
    it 'grants access to create todo' do
      expect(subject).to permit(User.new, Todo.new)
    end
  end

  permissions :index? do
    context 'user is todo owner' do
      it 'grants access to index todoes' do
        user = build(:user)
        todoes = build_list(:todo, 3, user: user)
        expect(subject).to permit(user, todoes)
      end
    end
  end

  permissions :delete? do
    context 'user is not todo owner' do
      it 'denies access to delete todo' do
        expect(subject).not_to permit(User.new, Todo.new)
      end
    end

    context 'user is todo owner' do
      it 'grants access to delete todo' do
        user = build(:user)
        todo = build(:todo, user: user)
        expect(subject).to permit(user, todo)
      end
    end
  end
end
