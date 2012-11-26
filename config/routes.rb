CarrierwaveMongolab::Application.routes.draw do
  resources :articles
  root :to => "articles#index"
  match "/images/uploads/*path" => "application#image" #thumbnail画像
end
