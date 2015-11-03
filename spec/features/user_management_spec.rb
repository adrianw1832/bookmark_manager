
feature 'User sign up' do
  let(:user) { build :user }
  scenario 'I can sign up as a new user' do
    expect { sign_up_as(user) }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, #{user.email}")
    expect(User.first.email).to eq(user.email)
  end

  scenario 'with a password that does not match' do
    user = build(:user, password_confirmation: 'wrong')
    expect { sign_up_as(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'I cannot sign up as a new user without an email' do
    user = build(:user, email: '')
    expect { sign_up_as(user) }.not_to change(User, :count)
  end

  scenario 'I cannot sign up with an existing email' do
    sign_up_as(user)
    click_button('Sign out')
    expect { sign_up_as(user) }.to change(User, :count).by(0)
    expect(page).to have_content('Email is already taken')
  end

  scenario 'with correct credentials' do
    user = create(:user)
    sign_in(user)
    expect(page).to have_content("Welcome, #{user.email}")
  end
end

feature 'User signs out' do
  scenario 'while being signed in' do
    user = create(:user)
    sign_in(user)
    click_button('Sign out')
    expect(page).to have_content('goodbye!')
    expect(page).not_to have_content("Welcome, #{user.email}")
  end
end

feature 'Password reset' do
  let(:user) { create(:user) }

  scenario 'requesting a password reset' do
    visit '/users/request_password_reset'
    fill_in('email', with: user.email)
    click_button('Reset password')
    user_updated = User.first(email: user.email)
    expect(user_updated.password_token).not_to be_nil
    expect(page).to have_content('Check your emails')
  end

  scenario 'resetting password' do
    user.update(password_token: 'token')
    visit("/users/password_reset/#{user.password_token}")
    expect(page.status_code).to eq 200
    expect(page).to have_content('Enter a new password')
  end

  scenario 'user can use new password after user resets the password' do
    user.update(password_token: 'token')
    visit "/users/password_reset/#{user.password_token}"
    fill_in('password', with: 'new password')
    fill_in('password_confirmation', with: 'new password')
    click_button('Update password')
    click_button('Sign out')
    sign_in(build(:user, password: 'new password'))
    expect(page).to have_content("Welcome, #{user.email}")
  end

  scenario 'user cannot use new password after user resets the password' do
    user.update(password_token: 'token')
    visit("/users/password_reset/#{user.password_token}")
    fill_in('password', with: 'new password')
    fill_in('password_confirmation', with: 'new password')
    click_button('Update password')
    click_button('Sign out')
    sign_in(user)
    expect(page).not_to have_content("Welcome, #{user.email}")
  end

  scenario 'token is deleted after users reset their password' do
    user.update(password_token: 'token')
    visit("/users/password_reset/#{user.password_token}")
    fill_in('password', with: 'new password')
    fill_in('password_confirmation', with: 'new password')
    click_button('Update password')
    visit("/users/password_reset/#{user.password_token}")
    expect(page).not_to have_content('New Password')
  end

  scenario 'user resets with a password that does not match' do
    user.update(password_token: 'token')
    visit("/users/password_reset/#{user.password_token}")
    fill_in('password', with: 'new password')
    fill_in('password_confirmation', with: 'old password')
    click_button('Update password')
    expect(page).to have_content('Password does not match the confirmation')
  end

  scenario 'user is taken to links after password reset'do
    user.update(password_token: 'token')
    visit("/users/password_reset/#{user.password_token}")
    fill_in('password', with: 'new password')
    fill_in('password_confirmation', with: 'new password')
    click_button('Update password')
    expect(page).to have_content("Welcome, #{user.email}")
  end
end
