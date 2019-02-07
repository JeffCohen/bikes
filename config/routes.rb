Rails.application.routes.draw do

  root 'stations#index'

  get '/stations' => 'stations#index'
  # get '/stations/search' => 'stations#search'
  # get '/stations/:id' => 'stations#show'

  get '/swapi/:things/' => 'swapi#index'
  get '/swapi/:things/:id' => 'swapi#show'

end
