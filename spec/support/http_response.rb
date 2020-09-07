# frozen_string_literal: true

RSpec.shared_examples '401' do
  it 'responds with 401' do
    subject
    expect(response).to have_http_status(:unauthorized)
  end
end

RSpec.shared_examples '403' do
  it 'responds with 403' do
    subject
    expect(response).to have_http_status(:forbidden)
  end
end