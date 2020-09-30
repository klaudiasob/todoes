user = FactoryBot.create(:user, email: 'user@example.com', password: 'password')
todoes = FactoryBot.create_list(:todo, 3, user: user)
