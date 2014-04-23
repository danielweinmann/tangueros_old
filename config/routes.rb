TangoPoa::Application.routes.draw do

  devise_for :users

  if Rails.env.development?
    get "/miv", to: "miv#index"
  end

  root to: "events#index"
  match '/sitemap' => "events#sitemap", :as => :sitemap
  
  resources :events do
    get "sitemap", on: :collection
  end

  resources :users, except: [:show, :new, :create] do
    get 'events', on: :member
  end

end
