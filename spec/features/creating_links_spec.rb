require 'spec_helper'

feature 'Creating links' do
  scenario 'I can create a new link' do
    visit '/links/new'
    fill_in 'url', with: 'http://www.zombo.com/'
    fill_in 'title', with: 'This is Zombocom'
    click_button 'Create link'
    expect(current_path).to eq '/links'
    within 'ul#links' do
      expect(page).to have_content('This is Zombocom')
    end
  end

  scenario 'there are no links in the database at the start of the test' do
    expect(Link.count).to eq 0
  end

  scenario 'Links created by different users will not be seen by others' do
    user = User.new(user_params)
    sign_up_as(user)
    visit '/links/new'
    fill_in 'url', with: 'http://www.test.com/'
    fill_in 'title', with: 'This is a test'
    click_button 'Create link'
    click_button 'Sign out'
    expect(page).not_to have_content('This is a test')
  end

  scenario 'Links created by the user will be seen again on login' do
    user = User.new(user_params)
    sign_up_as(user)
    visit '/links/new'
    fill_in 'url', with: 'http://www.zombo.com/'
    fill_in 'title', with: 'This is Zombocom'
    click_button 'Create link'
    click_button 'Sign out'
    sign_in(email: user.email, password: user.password)
    expect(page).to have_content('This is Zombocom')
  end
end
