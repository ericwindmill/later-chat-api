Rails.application.routes.draw do
  namespace :api, default: {format: :json} do
    resources :users, only: [:index, :create]
    resource :session, only: [:create, :destroy, :show]
    resources :posts, only: [:index, :create]
    resources :follows, only: [:create, :destroy]
  end
end


#  namespace :api, :defaults => {:format => :json} do
#     as :user do
#       post   "/sign-in"       => "sessions#create"
#       delete "/sign-out"      => "sessions#destroy"
#     end
#   end
