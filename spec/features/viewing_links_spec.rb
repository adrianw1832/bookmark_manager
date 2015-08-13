require 'spec_helper'

feature 'Viewing Links' do
  scenario 'I can filter links by tag' do
    user = User.new(user_params)
    sign_up_as(user)
    user.links << Link.create(url: 'http://www.makersacademy.com',
                              title: 'Makers Academy',
                              tags: [Tag.first_or_create(name: 'education')])
    user.save
    user.links << Link.create(url: 'http://www.google.com',
                              title: 'Google',
                              tags: [Tag.first_or_create(name: 'search')])
    user.save
    user.links << Link.create(url: 'http://www.zombo.com',
                              title: 'This is Zombocom',
                              tags: [Tag.first_or_create(name: 'bubbles')])
    user.save
    user.links << Link.create(url: 'http://www.bubble-bobble.com',
                              title: 'Bubble Bobble',
                              tags: [Tag.first_or_create(name: 'bubbles')])
    user.save
    visit '/tags/bubbles'
    within 'ul#links' do
      expect(page).not_to have_content('Makers Academy')
      expect(page).not_to have_content('Code.org')
      expect(page).to have_content('This is Zombocom')
      expect(page).to have_content('Bubble Bobble')
    end
  end
end
