# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount Api::Core => '/'

  root to: redirect('/api-docs')

  devise_for :users, controllers: { sessions: 'sessions' }
end
