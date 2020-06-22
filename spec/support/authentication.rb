# frozen_string_literal: true

RSpec.shared_context 'unauthenticated' do
  let(:headers) do
    {
      'Authorization' => 'Bearer'
    }
  end
end

RSpec.shared_context 'authenticated' do
  let(:headers) do
    {
      'Authorization' => "Bearer #{token}"
    }
  end

  let(:token) do
    payload = {
      'jti' => user.jti,
      'sub' => user.id,
      'exp' => Time.now.to_i + 3600
    }

    JWT.encode(payload, Rails.application.credentials.config[:secret_key_base])
  end
end
