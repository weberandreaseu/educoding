Rails.application.routes.draw do
  scope "(:locale)", locale: /en|de/ do
    get 'login' => 'sessions#new', as:'login'
    post 'login' => 'sessions#create'
    post 'sessions' => 'sessions#create', as: 'sessions'
    delete 'logout' => 'sessions#destroy', as: 'logout'

    get 'signup' => 'users#new', as: 'signup'
    post 'users' => 'users#create', as: 'users'
    root 'welcome#index'

    resources :tasks
    get 'task/:id/solve' => 'tasks#solve', as: 'solve_task'
    
    resources :solutions
    put 'solution/:id/run' => 'solutions#run', as: 'run_solution'
  end

  get '/:locale' => 'welcome#index'
  
end