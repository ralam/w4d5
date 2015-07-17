Rails.application.routes.draw do
resources :users


resource :session
resources :subs, except: [:destroy] do
  resources :posts, only: [:show, :new, :create]
end

resources :posts, except: [:index, :destroy, :show, :new, :create]
end
