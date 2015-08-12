class BookmarkManager < Sinatra::Base
  get '/users/password_reset' do
    erb :'users/password_reset'
  end

  post '/users/password_reset' do
    user = User.first(email: params[:email])
    user.password_token = rand_token
    user.save
    flash[:notice] = 'Check your emails'
  end

  get '/users/password_reset/:token' do
    @user = User.first(password_token: params[:token])
  end
end
