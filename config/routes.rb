Mom::Application.routes.draw do

  root to: "welcome#index"

  post 'welcome', to: "welcome#create"

  devise_for :users, :controllers => {registrations: 'registrations', sessions: 'sessions'}
  
end
