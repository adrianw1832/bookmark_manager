class BookmarkManager < Sinatra::Base
  get '/users/password_reset/:token' do
    session[:token] = params[:token]
    erb :'users/password_reset'
  end

  post '/users/password_reset' do
    user = User.first(password_token: session[:token])
    if user.update(password: params[:password],
                   password_confirmation: params[:password_confirmation],
                   password_token: nil)
      session[:user_id] = user.id
      redirect '/'
    else
      flash[:errors] = user.errors.full_messages
    end
  end
end
