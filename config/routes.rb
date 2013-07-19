Writing::Application.routes.draw do
  root 'application#index'

  get '/user/login', to: 'user#login'
  get '/user/login/callback', to: 'omniauth_github#callback'
end
