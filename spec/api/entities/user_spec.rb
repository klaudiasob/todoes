# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Entities::User do
  describe 'exposed attributes' do
    subject { described_class.represent(user).serializable_hash }

    let(:user) { create(:user) }

    it 'exposes one attribute' do
      expect(subject.size).to eq 1
    end

    it 'exposes only user email' do
      expect(subject[:email]).to eq user.email
    end
  end
end
