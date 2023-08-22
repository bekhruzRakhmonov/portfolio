# config/routes.rb

Rails.application.routes.draw do
  root 'pages#welcome'
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  post 'contact', to: 'pages#send_contact'
  get 'work', to: 'pages#work'
  get 'thanks', to: 'pages#thanks'
end
