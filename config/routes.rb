Rails.application.routes.draw do
  #get 'sessions/create'

  #get 'sessions/destroy'

#  get 'session/create'

#  get 'session/destroy'

#  get 'activities/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   resources :activities do
      resources :likes, only: [:create, :destroy]
   end

 resource :sessions
 root to: 'activities#index'

end
