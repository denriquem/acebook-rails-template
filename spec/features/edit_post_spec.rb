RSpec.feature "Timeline", type: :feature do

  before(:each) do
    sign_up('test1@example.com', 'testone')
    new_post("Old message from test 1")
  end

  scenario 'can edit posts' do
    click_on 'Edit'
    fill_in "post[message]", with: 'Updated message from test 1'
    click_on 'Update Post'
    expect(page).to have_content("Successfully edited the message")
    expect(page).to_not have_content('Old message from test 1')
    expect(page).to have_content('Updated message from test 1')
  end

  scenario "can edit own post when there are two posts" do
    click_button 'Sign out'
    sign_up('test2@example.com', 'testtwo')
    new_post('Old message from test 2')
    all('a', :text => 'Edit')[0].click
    fill_in "post[message]", with: 'Updated message from test 2'
    click_on 'Update Post'
    expect(page).to have_content('Updated message from test 2')
    expect(page).to_not have_content('Old message from test 2')
    expect(page).to have_content('Successfully edited the message')
  end

  scenario "can not edit someone else's posts" do
    click_button 'Sign out'
    sign_up('test2@example.com', 'testtwo')
    new_post('Old message from test 2')
    all('a', :text => 'Edit')[1].click
    fill_in "post[message]", with: 'Updated message from test 2'
    click_on 'Update Post'
    expect(page).to have_content('You are not logged in as the correct user')
  end

end
