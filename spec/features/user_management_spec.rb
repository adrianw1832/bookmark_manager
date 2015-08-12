feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    user = User.new(user_params)
    expect { sign_up_as(user) }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'requires a matching confirmation password' do
    user = User.new(user_params_without_password)
    expect { sign_up_as(user) }.not_to change(User, :count)
  end

  scenario 'with a password that does not match' do
    user = User.new(user_params_without_password)
    expect { sign_up_as(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content "Password does not match the confirmation"
  end

  scenario 'I cannot sign up as a new user without an email' do
    user = User.new(user_params_without_email)
    expect { sign_up_as(user) }.not_to change(User, :count)
  end

  scenario 'I cannot sign up with an existing email' do
    user = User.new(user_params)
    sign_up_as(user)
    expect { sign_up_as(user) }.to change(User, :count).by(0)
    expect(page).to have_content('Email is already taken')
  end

  let(:user) do
    User.create(email: 'user@example.com',
                password: 'secret1234',
                password_confirmation: 'secret1234')
  end

  scenario 'with correct credentials' do
    sign_in(email: user.email, password: user.password)
    expect(page).to have_content "Welcome, #{user.email}"
  end
end

feature 'User signs out' do
  before(:each) do
    User.create(email: 'test@test.com',
                password: 'test',
                password_confirmation: 'test')
  end

  scenario 'while being signed in' do
    sign_in(email: 'test@test.com', password: 'test')
    click_button 'Sign out'
    expect(page).to have_content('goodbye!')
    expect(page).not_to have_content('Welcome, test@test.com')
  end
end

feature 'Password reset' do
  before(:each) do
    User.create(email: 'test@test.com', password: 'secret1234',
                password_confirmation: 'secret1234')
  end

  scenario 'requesting a password reset' do
    visit '/users/password_reset'
    user = User.first
    fill_in 'email', with: user.email
    click_button 'Reset password'
    user = User.first(email: user.email)
    expect(user.password_token).not_to be_nil
    expect(page).to have_content 'Check your emails'
  end

  xscenario 'resetting password' do
    user = User.first
    user.password_token = 'token'
    user.save
    visit "/users/password_reset/#{user.password_token}"
    expect(page.status_code).to eq 200
    expect(page).to have_content 'Enter a new password'
  end

  xscenario 'user can reset their password' do
    user = User.first
    user.password_token = 'token'
    user.save
    visit "/users/password_reset/#{user.password_token}"
    fill_in 'new_password', with: 'new_password'
    expect(user.password).to eq 'new_password'
  end
end
