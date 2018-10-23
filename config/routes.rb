Rails.application.routes.draw do
  root to: "clients#index"

  resources :clients do
    resources :invoices do
      resources :payments
    end
    resources :budgets

    resources :line_items, only: [:update]
    resources :works, except: [:index, :show] do
      post :merge, on: :collection
      post :convert, on: :member
    end
    resources :adjustments, except: [:index, :show]
    resources :assignments, only: [:new, :create, :destroy]
  end

  resources :payments
  resources :adjustments, except: [:index, :show]
  resources :assignments, only: [:new, :create, :destroy]
  resources :works, except: [:index, :show]

  match "/clients/:client_id/clock_in(.:format)"            => "works#clock_in",  :as => "clock_in", :via => [:get, :post]
  match "/clients/:client_id/works/:id/clock_out(.:format)" => "works#clock_out", :as => "clock_out", :via => [:get, :post]

  get "/calendar(/:year(/:month))" => "calendar#index", :as => "calendar"

  resources :users
  resource :account, controller: "users"
  resource :user_session

  get "login" => "user_sessions#new"
  delete "logout" => "user_sessions#destroy"

  resource :install, only: [:new, :create]

  match ":controller(/:action(/:id(.:format)))", via: [:get, :post]
end
