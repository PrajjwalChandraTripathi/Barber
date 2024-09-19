Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { registrations: 'api/v1/registrations' }

  namespace :api do
    namespace :v1 do
      resources :shops do
        resources :ratings, only: [:index, :show, :create]  
        resources :menu_items
        resources :time_slots 
      end
      resources :users, only: [:create] do
        get 'shops', to: 'shops#specific_user_shop' # Custom route for specific user's shops
        resources :shops, only: [:create, :update, :destroy] do 
          resources :time_slots do
            resources :bookings, only: [:create]
          end
        end
        member do
          put :set_role
        end
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
