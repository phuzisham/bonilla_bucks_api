Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :users do
    resources :accounts do
      resources :withdrawls
      resources :deposits
    end
  end
end
