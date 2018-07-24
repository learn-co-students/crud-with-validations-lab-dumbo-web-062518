Rails.application.routes.draw do
  resources :songs

  delete '/songs/:id', to: 'song#destroy', as:'delete_song'
end
