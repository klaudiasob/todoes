RSpec.shared_examples '401' do
  it 'responds with 401' do
    subject
    expect(response).to have_http_status(:unauthorized)
  end
end