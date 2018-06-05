Rails.application.routes.draw do

  # Added by Koudoku.
  mount Koudoku::Engine, at: 'koudoku'
  scope module: 'koudoku' do
    get 'tarifs' => 'subscriptions#index', as: 'pricing'
  end


  mount ForestLiana::Engine => '/forest'
  mount Attachinary::Engine => "/attachinary"
  devise_for :users,
             controllers: {
             registrations: "registrations",
             users: 'users'
          }

  namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :evaluations, only: [:index, :show, :create ]
        resources :users, only: [:show]
      end
  end

  resources :users, only: [:show, :update]
  resources :evaluations, only: [:create, :update]
  resources :sinistres, only: [:index]
  resources :locataires do
    resources :sinistres, only: [:create, :update, :new, :show]
  end
  resources :resolutions
  resources :comparaisons, only: :create

  root to: 'pages#home'
  get "/espace_locataire" => "pages#espace_locataire"
  get "/comparaison-de-profils" => "comparaisons#comparaison_profils"
  get "/gestion-des-parcs" => "users#gestion_parc"
  get "/mise-a-jour-sinistres" => "sinistres#maj_sinistres"
  get "/informations" => "informations#infentreprise"
  # get "informations/download_csv"
  get "informations/download_xlsx"
  # get "informations/download_sinistralite_csv"
  get "/informations/import_locataires" => "informations#import_loc"

  # post "informations/import_csv" => "informations#import_csv"
  # post "informations/import_sinistralites_csv" => "informations#import_sinistralites_csv"
  post "informations/import_xlsx" => "informations#import_xlsx"
  post "informations/import_json" => "informations#import_json"
  match "/search", to: 'users#show', via: 'get'



  get '*path' => redirect('/')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
