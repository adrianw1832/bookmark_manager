feature 'Viewing Links' do
  scenario 'I can filter links by tag' do
    bubble_tag = create(:tag, name: 'bubbles')
    non_bubble_tag = create(:tag)

    user = build(:user)
    sign_up_as(user)
    create(:link, title: 'Bubble Bobble', tags: [bubble_tag])
    create(:link, title: 'This is Zombocom', tags: [bubble_tag])
    create(:link, title: 'Potatoland', tags: [non_bubble_tag])
    create(:link, title: 'The Potato Rises', tags: [non_bubble_tag])

    visit '/tags/bubbles'
    within 'ul#links' do
      expect(page).not_to have_content('Makers Academy')
      expect(page).not_to have_content('Code.org')
      expect(page).to have_content('This is Zombocom')
      expect(page).to have_content('Bubble Bobble')
    end
  end
end
