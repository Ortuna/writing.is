Writing::Application.routes.draw do
  root 'homepage#index'

  get '/user/login',  to: 'users#login'
  get '/user/logout', to: 'users#logout'
  get '/user/login/callback',  to: 'omniauth_github#callback'
  get '/auth/github/callback', to: 'omniauth_github#callback'

  resources :repos, only: [:index] do
    resources :files, only: [:index]
  end

end
