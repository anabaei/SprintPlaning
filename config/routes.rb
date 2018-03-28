Rails.application.routes.draw do
  get 'activities/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   resources :activities do
      resources :likes, only: [:create, :destroy]
   end

 root to: 'activities#index'

end
