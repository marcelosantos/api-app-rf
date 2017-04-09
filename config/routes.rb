Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :usuarios do
    resources :bems
  end
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'usuarios#create'
end
