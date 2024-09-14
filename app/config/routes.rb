Rails.application.routes.draw do
  # Movies routes
  get "movies", to: "movies#index"
  get "movies/:id", to: "movies#show"
  post "movies", to: "movies#create"
  match "movies/:id", to: "movies#update", via: [:put, :patch]
  delete "movies/:id", to: "movies#destroy"

  # Reviewers routes
  get "reviewers", to: "reviewers#index"
  get "reviewers/:id", to: "reviewers#show"
  post "reviewers", to: "reviewers#create"
  match "reviewers/:id", to: "reviewers#update", via: [:put, :patch]
  delete "reviewers/:id", to: "reviewers#destroy"

  # Comment2 routes
  get "comment2s", to: "comment2s#index"
  get "comment2s/:id", to: "comment2s#show"
  post "comment2s", to: "comment2s#create"
  match "comment2s/:id", to: "comment2s#update", via: [:put, :patch]
  delete "comment2s/:id", to: "comment2s#destroy"
end
