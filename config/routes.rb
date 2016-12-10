Rails.application.routes.draw do
  resources :appointments, only: [:index, :show, :create]
  resources :interface_documents, only: [:index, :show, :create, :update, :destroy]
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
