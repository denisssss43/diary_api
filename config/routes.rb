Rails.application.routes.draw do
    require 'sidekiq/web'
    require 'sidekiq-scheduler/web'

    namespace :api do
        namespace :v1 do
            resources :diaries 
            resources :notes
        end
    end
    
    mount Sidekiq::Web, at: '/sidekiq'

end
