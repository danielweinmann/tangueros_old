TangoPoa::Application.routes.draw do
  if Rails.env.development?
    get "/miv", to: "miv#index"
  end

  root to: "miv#index"
end
