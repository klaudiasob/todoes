# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:finished) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user).class_name('User') }
  end
end
