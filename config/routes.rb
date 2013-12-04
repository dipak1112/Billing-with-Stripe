BillingWithStripe::Application.routes.draw do
  resources :plans
  resources :subscriptions
  root 'home#index'

end
