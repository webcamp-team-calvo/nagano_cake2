Rails.application.routes.draw do
  devise_for :customers, skip: 'registrations'
  devise_for :admins
  
  devise_scope :customer do
    get 'edit' => 'devise/registrations#edit'
    get '/customers/sign_up' => 'devise/registrations#new', as: :new_customer_registration
    post '/customers' => 'devise/registrations#create'
  end
  
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :categories, only: [:new, :create, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: [:update]
    root to: 'homes#top'
  end
  
  scope module: :public do
    resource :customers, only: [:show, :edit, :update]
    get '/customers/quit' => 'customers#quit'
    patch '/customers/out' => 'customers#out'
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :create, :destroy, :show]
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :orders, only: [:new, :create, :index, :show]
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/thanks' => 'orders#thanks'
    resources :deliveries, only: [:index, :create, :destroy, :edit, :update]
    root to: 'homes#top'
    get '/about' => 'homes#about'
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
