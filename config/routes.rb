Mom::Application.routes.draw do

  root to: "welcome#index"

  post 'welcome', to: "welcome#create"
  post 'custom_text', to: "welcome#custom_text"
  
  devise_for :users, :controllers => {registrations: 'registrations', sessions: 'sessions'}
  
end
