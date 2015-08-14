module BookmarkManager
  module Routes
    module Users
      class Signup < Base
        get '/users/new' do
          @user = User.new
          erb :'users/new', layout: false
        end

        post '/users' do
          @user = User.create(email: params[:email],
                              password: params[:password],
                              password_confirmation: params[:password_confirmation])
          if @user.save
            session[:user_id] = @user.id
            redirect '/links'
          else
            flash.now[:errors] = @user.errors.full_messages
            erb :'users/new'
          end
        end
      end
    end
  end
end
