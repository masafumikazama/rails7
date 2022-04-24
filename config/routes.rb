# frozen_string_literal: true

Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  mount RailsAdmin::Engine => '/_system_admin_', as: 'rails_admin'
  devise_scope :user do
    root to: 'users/sessions#new'
  end

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :managers, controllers: {
    sessions:      'managers/sessions',
    passwords:     'managers/passwords',
    registrations: 'managers/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  namespace :admins do
  end

  namespace :managers do
    resources :books, param: :uuid
    resources :dashboards, only: [:index]
    resources :general_managers
    resources :import_books, only: %i[new create]
    get "/book_csv/:id/status" => "import_books#status"
    resources :users, only: %i[index show]
    get :show, path: '/account', to: 'account#show'
    get :edit, path: '/account/edit', to: 'account#edit'
    patch :update, path: '/account', to: 'account#update'
  end

  namespace :users do
    resources :books, param: :uuid, only: %i[index show]
    resources :dashboards, only: [:index]
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
