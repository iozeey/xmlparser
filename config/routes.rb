Rails.application.routes.draw do

  root to: 'converter#index'

  resources :converter do 
    collection { post :import }
  end
end
