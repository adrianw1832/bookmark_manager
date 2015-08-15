module SessionHelpers
  def sign_in(user)
    visit '/'
    click_link('Sign in')
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button 'Sign in'
  end

  def sign_up_as(user)
    visit '/'
    click_link('Sign up')
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    click_button 'Sign up'
  end
end
