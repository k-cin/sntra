require 'rubygems'
require 'sinatra'
require 'httparty'

require_relative 'models/book.rb'
get '/' do
  erb :index
end

get '/books' do
  class Book
    include HTTParty

    base_uri 'https://www.googleapis.com/books/v1/volumes'
    format :json

    def self.search(term)
      cleaned_up_term = term.gsub(/\s+/, '+')
      get('', query: { q: cleaned_up_term, startIndex: 0, maxResults: 40 })['items'] || []
    end
  end

  @search_term = params[:q] || '49ers'
  @books = Book.search(@search_term)

  erb :"books/index"
end

get '/book/:q' do
  @search_term = params[:q]
  @books = Book.search(@search_term)

  erb :"books/index"
end
