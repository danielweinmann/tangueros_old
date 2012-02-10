TangoPoa::Application.routes.draw do
  if Rails.env.development?
    get "/miv", to: "miv#index"
  end

  root to: "events#index"
  
  resources :events, only: [:index, :create]
  
end
