class RPS < Sinatra::Base

  get '/sessions/new' do
    if current_user
      redirect '/'
    else
      erb(:'sessions/new')
    end
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect to('/')
    else
      flash.now[:errors] = ['The email or password is incorrect.']
      erb(:'sessions/new')
    end
  end

  get '/sessions/delete' do
    session.destroy
    redirect '/'
  end
end

=begin
  delete '/sessions' do
    session[:user_id] = nil
    flash.keep[:notice] = 'goodbye!'
    redirect to '/sessions/new'
  end
=end
