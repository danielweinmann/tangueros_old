Tangueros::Application.routes.draw do

  devise_for :users

  if Rails.env.development?
    get "/miv", to: "miv#index"
  end

  get '/sitemap' => "events#sitemap", :as => :sitemap
  
  resources :events, except: [:index] do
    get "sitemap", on: :collection
  end

  resources :users, except: [:show, :new, :create] do
    get 'events', on: :member
  end

  root "events#index"

end
