DataEngineering::Application.routes.draw do
  devise_for :users
  root 'imports#new'
end
