# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :skus
  resources :webhooks, only: [:create]

  root 'skus#index'
end
