# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  describe 'associations' do
    it { is_expected.to have_many(:todoes).class_name('Todo') }
  end
end
