require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:finished) }
  end

  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
  end

end
