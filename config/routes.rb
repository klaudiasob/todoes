# frozen_string_literal: true

Rails.application.routes.draw do
  mount Api::Core => '/'

  devise_for :users, controllers: { sessions: 'sessions' }
end
