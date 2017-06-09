rails new abc
cd abc
rails g scafflod book name:string author:string
rails g model book name:string author:string
rake  db:migrate

# config/routes.rb
Rails.application.routes.draw do
  root 'books#index'
  namespace :api do
    namespace :v1 do
      resources :books
    end
  end
end

# app/controllers/api/v1/books_controller.rb
module Api
  module V1
    class BooksController < ApplicationController
      def index
        render json: {message: 'Message 1'}, status: 200
      end
    end
  end
end


# call it
http://localhost:3000/api/v1/books
