Rails.application.routes.draw do
  root 'epicenter#feed'
   
   # post '/' => "epicenter#feed", as: "root"


   post 'epicenter/epi_tweet'

  get 'tag_tweets' => 'epicenter#tag_tweets'
 
  get 'show_user' => 'epicenter#show_user'

  get 'now_following' => 'epicenter#now_following'

  get 'unfollow' =>'epicenter#unfollow'

  get 'all_users' => 'epicenter#all_users'

  resources :tweets
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
