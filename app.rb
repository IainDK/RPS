require 'sinatra/base'
require 'sinatra/flash'
require './lib/game'

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

  # start the server if ruby file executed directly
  run! if app_file == $0
end
