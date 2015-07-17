Rails.application.routes.draw do
resources :users do
  resources :subs, only:[:edit, :update]
end
resource :session
resources :subs, except: [:destroy, :edit, :update]
end
