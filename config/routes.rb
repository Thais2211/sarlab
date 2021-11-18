Rails.application.routes.draw do

  resources :lessons do
    collection do
      post 'new_lesson'
      post 'review'
    end
  end
  
  resources :schedules do
    collection do
      get 'get_schedules'
      post 'save_schedule'
      post 'aprovar'
      post 'reject'
      post 'cancel'
      get 'activities'
    end
  end
    
  resources :type_reservations do
    collection do
      post 'novo_tipo'
      post 'atualizar_tipo'
    end
  end

  resources :equipaments do
    collection do
      get 'equipaments_labs'
      get 'equipaments_labs_json'
      post 'toggle_eqp'
    end
  end
  
  resources :laboratorys do
    collection do
      post 'new_laboratory'
      post 'edit_laboratory'
      get 'get_laboratory'  
      post 'toggle_lab'
    end
  end
  
  resources :disciplinas do
    collection do
      get 'find_professor'
      post 'nova_disciplina'
      get 'get_disciplina' 
      post 'atualizar_disciplina'     
      post 'toggle'
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
  resources :users do
    member do
      get 'toggle_user'
    end
    collection do
      post 'alter_permission'
      post 'alter_password'
    end
  end

  resources :upload do
    collection do
      get 'download_file'
      get 'remove_file'
    end
  end
  
  mount ExceptionLogger::Engine => "/exception_logger"
end
