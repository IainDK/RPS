ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require './app/lib/game'
require './app/models/user'

class RPS < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  before do
    @game = Game.instance
  end

  get '/' do
    erb(:index)
  end

  post '/play' do
    player = Player.new(params[:name])
    @game = Game.create(player)
    erb(:play)
  end

  post '/result' do
    @game.player.player_weapon(params[:weapon].to_sym)
    erb(:result)
  end

  get '/users' do
    @users = User.all
    erb(:users)
  end

  get '/users/new' do
    erb(:users_new)
  end

  post '/users' do
    User.create(name: params[:name])
    redirect '/users'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
