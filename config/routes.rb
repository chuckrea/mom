Mom::Application.routes.draw do

  root to: "welcome#index"

  devise_for :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

end
