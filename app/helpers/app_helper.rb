module ApplicationHelpers
  def current_user
    @current_user ||= User.get(session[:user_id])
  end

  def rand_token
    [*'A'..'Z'].shuffle.join
  end

  def token?
    User.first(password_token: session[:token])
  end
end
