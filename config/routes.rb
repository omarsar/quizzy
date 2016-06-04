Rails.application.routes.draw do
  resources :answers
  
  resources :questions do
    member do
      put "check", to: "questions#check"
    end
    resource :answers
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'questions#index'
end
