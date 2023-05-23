Rails.application.routes.draw do
  resources :orders

  post '/update_order_status/:nonce', to: 'orders#update_order_status'

  constraints Clearance::Constraints::SignedIn.new do
    root to: "orders#index", as: :signed_in_root
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: "clearance/sessions#new"
  end
end
