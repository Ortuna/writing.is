Writing::Application.routes.draw do
  root 'application#index'

  match '/user/login', to: 'user#login', via: [:get]
end
