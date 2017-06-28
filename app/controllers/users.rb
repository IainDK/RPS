class RPS < Sinatra::Base

  get '/users/new' do
    if current_user
      redirect '/'
    else
      @user = User.new
      erb(:'users/new')
    end
  end

  post '/users' do
    @user = User.create(name: params[:name],
                       email: params[:email],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb(:'users/new')
    end
  end

  get '/users/:id' do
    @user_id = User.get(params[:id])
    if @user_id
      @victories = Victory.all(:user => @user_id)
      @draws = Draw.all(:user => @user_id)
      @defeats = Defeat.all(:user => @user_id)
      erb(:'users/id')
    else
      erb(:'users/error')
    end
  end
end
