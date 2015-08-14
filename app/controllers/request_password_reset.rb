module BookmarkManager
  module Routes
    module Users
      class RequestPasswordReset < Base
        get '/users/request_password_reset' do
          erb :'users/request_password_reset'
        end

        post '/users/request_password_reset' do
          user = User.first(email: params[:email])
          user.update(password_token: rand_token)
          flash[:notice] = 'Check your emails'
        end
      end
    end
  end
end
