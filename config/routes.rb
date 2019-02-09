Rails.application.routes.draw do

  root 'stations#index'

  get '/stations' => 'stations#index'
  # get '/stations/search' => 'stations#search'
  # get '/stations/:id' => 'stations#show'

  get '/swapi/:things/' => 'swapi#index', defaults: { format: 'json' }
  get '/swapi/:things/:id' => 'swapi#show', defaults: { format: 'json' }

end
