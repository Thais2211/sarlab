Rails.application.routes.draw do

  resources :disciplinas do
    collection do
      get 'find_professor'
      post 'nova_disciplina'
      get 'get_disciplina'      
    end
    member do
      put 'atualizar_disciplina'
    end
  end

  resources :escolas do
    collection do
      get 'nova_escola'
      get 'atualizar_escola'
    end
  end

  root to: 'welcome#index'
  get 'welcome/index'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'

  }
  resources :roles
  resources :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
