Rails.application.routes.draw do
  resources :sms_tokens
  resources :appointments, only: [:index, :show, :create]
  resources :interface_documents, only: [:index, :show]

  ################### devise_for ####################
  devise_for :admins
  devise_for :users

  ################### admin #########################
  namespace :admin do
  	resources :appointments, only: [:index, :show]
    resources :interface_documents, only: [:index, :show, :create, :update, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
