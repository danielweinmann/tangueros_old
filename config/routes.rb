Tangueros::Application.routes.draw do

  devise_for :users

  if Rails.env.development?
    get "/miv", to: "miv#index"
  end

  get '/sitemap' => "events#sitemap", :as => :sitemap
  
  resources :events, except: [:index, :edit] do
    collection do
      get "happening"
      get "upcoming"
      get "past"
      get "sitemap"
    end
  end

  root "events#index"

end
