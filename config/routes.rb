Writing::Application.routes.draw do
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
  root 'homepage#index'

  get '/user/login',  to: 'users#login'
  get '/user/logout', to: 'users#logout'
  get '/user/login/callback',  to: 'omniauth_github#callback'
  get '/auth/github/callback', to: 'omniauth_github#callback'
  get '/editor', to: 'editor#index', as: :editor

end
