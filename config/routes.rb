# config/routes.rb

Rails.application.routes.draw do
  root 'pages#welcome'
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'work', to: 'pages#work'
end
