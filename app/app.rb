ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require_relative 'server'
require_relative 'models/game'
require_relative 'models/user'
require_relative 'controllers/users'
require_relative 'controllers/sessions'
require_relative 'datamapper_setup'

class RPS < Sinatra::Base

  before do
    @game = Game.instance
  end

  get '/' do
    if current_user
      erb(:index)
    else
      redirect '/users/new'
    end
  end

  post '/play' do
    user = current_user
    @game = Game.create(user)
    erb(:play)
  end

  post '/result' do
    @game.user.user_weapon(params[:weapon].to_sym)
    erb(:result)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
