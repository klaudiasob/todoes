# frozen_string_literal: true

RSpec.shared_context 'authorized' do |policy_class, policy_method|
  before do
    allow(policy_class).to receive(:new).and_return(
      instance_double('policy', policy_method => true)
    )
  end
end

RSpec.shared_context 'unauthorized' do |policy_class, policy_method|
  before do
    allow(policy_class).to receive(:new).and_return(
      instance_double('policy', policy_method => false)
    )
  end
end
