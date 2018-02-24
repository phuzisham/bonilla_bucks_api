Rails.application.routes.draw do
  resources :accounts do
    resources :withdrawls
    resources :deposits
  end
end
