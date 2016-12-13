Rails.application.routes.draw do
  
  resources :appointments, only: [:index, :show, :create]
  resources :interface_documents, only: [:index, :show]

  ################### devise_for ####################
  devise_for :admins
  devise_for :users

  ################### admin #########################
  namespace :admin do
  	resources :appointments, only: [:index, :show] do
      member do
        post :accept
        post :refuse
      end
    end
    resources :interface_documents, only: [:index, :show, :create, :update, :destroy]
  end

  ########### UserInfo Route ################
  resource :user_info, only: [:show, :update] do
    member do
      post 'reset'
    end
  end

  ############ SMS Routes ###################
  resources :sms_tokens, only: [:show]  do
    collection do
      post 'register'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
