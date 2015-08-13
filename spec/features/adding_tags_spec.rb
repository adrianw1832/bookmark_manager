require 'spec_helper'

feature 'Adding tags' do
  let(:user) { User.new(user_params) }

  scenario 'I can add multiple tags to a new link' do
    sign_up_as(user)
    visit '/links/new'
    fill_in 'url', with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tags', with: 'education ruby'
    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education', 'ruby')
  end
end
