require 'pg'

feature 'viewing bookmarks' do
  scenario 'displays bookmarks' do
    Bookmark.add_new(
      'http://www.makersacademy.com',
      'Makers Academy'
    )
    Bookmark.add_new(
      'http://www.google.com',
      'Google'
    )
    Bookmark.add_new(
      'http://www.destroyallsoftware.com',
      'Destroy All Software'
    )

    visit '/bookmarks'
    expect(page).to have_link(
      'Makers Academy',
      href: 'http://www.makersacademy.com'
    )
    expect(page).to have_link(
      'Destroy All Software',
      href: 'http://www.destroyallsoftware.com'
    )
    expect(page).to have_link(
      'Google',
      href: 'http://www.google.com'
    )
  end
end

feature 'adding bookmarks' do
  scenario 'add a new bookmark' do
    visit '/'
    click_button 'Add New'
    fill_in 'url', with: 'http://www.bbc.co.uk'
    fill_in 'title', with: 'BBC'
    click_button 'Submit'
    click_button 'View Bookmarks'
    expect(page).to have_link('BBC', href: 'http://www.bbc.co.uk')
  end
end

feature 'deleting bookmarks' do
  scenario 'delete a new bookmark' do
    Bookmark.add_new('http://www.makersacademy.com', 'Makers Academy')
    visit '/'
    click_button 'View Bookmarks'
    first('.bookmark').click_button 'Delete'
    expect(page).not_to have_link('Makers Academy', href: 'http://www.makersacademy.com')
  end
end

feature 'update bookmarks' do
  scenario 'change title' do
    create_test_rows
    visit '/bookmarks'
    first('.bookmark').click_button 'Update'
    fill_in 'title', with: 'Makers
    # fill_in 'url', with: 'http://www.makersacademy.com'
    click_button 'Submit'
    # save_and_open_page
    expect(page).to have_link('Makers')
  end
end
