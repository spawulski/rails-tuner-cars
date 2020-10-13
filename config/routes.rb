# frozen_string_literal: true

Rails.application.routes.draw do
  get 'provinces/index'
  get 'models/index'
  get 'models/show'
  get 'makes/index'
  get 'listings/index'
  get 'listings/show'

  resources :makes, only: %i[index show]
  resources :listings, only: %i[index show]
  resources :models, only: %i[index show]

  get '/:page' => 'static#show'

  root to: 'listings#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
