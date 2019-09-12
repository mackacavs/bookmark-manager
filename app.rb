require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/bookmark'
require_relative './database_connection_setup'
require 'uri'

class BookmarkManager < Sinatra::Base

  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  get '/new' do
    erb :new
  end

  post '/new' do
    if Bookmark.valid(params[:url])
      Bookmark.add_new(params[:url], params[:title])
    else
      flash[:notice] = 'Please enter valid URL!'
    end
    redirect '/'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(params['id'])
    redirect '/bookmarks'
  end

  post '/update/:id' do
    @bookmark = Bookmark.find(params[:id])
    erb :update
  end

  patch '/bookmarks/:id' do
    Bookmark.update(params[:id], params[:title], params[:url])
    redirect '/bookmarks'
  end

  run! if app_file == $PROGRAM_NAME
end
