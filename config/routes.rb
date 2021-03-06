Rails.application.routes.draw do

  resource :apis do
    get :api_date
  end

  resources :records, only: [:index, :show] do
    collection do
      get :list
    end
  end
  resources :appointment_items, only: [:index, :show]
  resources :appointments, only: [:index, :show, :create] do
    collection do 
      get :all_appointment_items
    end
    resources :appointment_items, only: [:index, :show]
  end

  resources :interface_documents, only: [:index, :show] do
    collection do 
      get :list
      get :details
    end
    member do 
      get :get_detail_json
    end
    resources :statis_infos
  end
  ################### devise_for ####################
  devise_for :admins
  devise_for :users, controllers: {
    # registrations: 'registerable/registrations'
  }

  ################### admin #########################
  namespace :admin do
    resources :manager_apis, only: [:index, :show]
    resources :manager_accounts, only: [:index, :show, :destroy] do 
      collection do 
        post :reset_password
        post :destroy_others
      end
    end
  	resources :appointments, only: [:index, :show] do
      member do 
        post :audit
      end
      collection do 
        post :audit_multi
      end
      resources :appointment_items, only: [:index, :show]do
        member do
          post :accept
          post :refuse
        end  
      end
    end
    resources :interface_documents, only: [:index, :show, :create, :update, :destroy] do
      resources :statis_infos
    end
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
