# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class }

  permissions :update? do
    context 'user is not current user' do
      it 'denies access to update user' do
        expect(subject).not_to permit(User.new, User.new)
      end
    end

    context 'user is current user' do
      it 'grants access to update user' do
        current_user = User.new
        expect(subject).to permit(current_user, current_user)
      end
    end
  end

  permissions :create? do
    it 'grants access to create user' do
      expect(subject).to permit(User.new)
    end
  end

  permissions :show? do
    context 'user is not current user' do
      it 'denies access to show user' do
        expect(subject).not_to permit(User.new, User.new)
      end

      context 'user is current user' do
        it 'grants access to show user ' do
          user = User.new
          expect(subject).to permit(user, user)
        end
      end
    end
  end

  permissions :delete? do
    context 'user is not current user' do
      it 'denies access to delete user' do
        expect(subject).not_to permit(User.new, User.new)
      end
    end

    context 'user is current user' do
      it 'grants access to delete user' do
        user = User.new
        expect(subject).to permit(user, user)
      end
    end
  end
end
