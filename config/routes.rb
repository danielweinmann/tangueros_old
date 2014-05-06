Tangueros::Application.routes.draw do

  devise_for :users

  if Rails.env.development?
    get "/miv", to: "miv#index"
  end

  get '/sitemap' => "events#sitemap", :as => :sitemap
  
  resources :events, except: [:index] do
    get "sitemap", on: :collection
  end

  root "events#index"

end
