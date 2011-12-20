Bootstrap31::Application.routes.draw do
  if Rails.env.development?
    get "/miv", to: "miv#index"
  end
end
