Rails.application.routes.draw do

    #index page
    root "home#index"
    #about page
    get "/about" => "home#about"

    resources :users, only: [:new, :create, :edit, :update]
    get "/change_password" => "users#change_password"
    patch "/change_password" => "users#update_password", as: :update_password

    # get "/edit/user" => "user#edit"

    #USER CONTROL
    resources :sessions, only: [:new, :create] do
        delete :destroy, on: :collection
    end
    #BLOG CONTROL
    resources :posts do
        resources :comments, only:[:create, :destroy]
    end
    resources :comments

#     Running via Spring preloader in process 58764
#     Prefix Verb   URI Pattern               Controller#Action
#      root GET    /                         home#index
#     about GET    /about(.:format)          home#about
#     posts GET    /posts(.:format)          posts#index
#           POST   /posts(.:format)          posts#create
#  new_post GET    /posts/new(.:format)      posts#new
# edit_post GET    /posts/:id/edit(.:format) posts#edit
#      post GET    /posts/:id(.:format)      posts#show
#           PATCH  /posts/:id(.:format)      posts#update
#           PUT    /posts/:id(.:format)      posts#update
#           DELETE /posts/:id(.:format)      posts#destroy

end
