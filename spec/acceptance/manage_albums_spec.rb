require 'acceptance_helper'

feature 'User can create albums' do
  let(:user) { Fabricate(:confirmed_user) }
  let(:album) { Fabricate.build(:album) }

  background do
    sign_in user
  end

  scenario 'with valid info' do
    visit homepage

    click_link 'New Album'
    within('#new_album') do
      fill_in 'Title', with: album.title
      fill_in 'Description', with: album.description
    end
    click_button 'Create'

    page.should have_content 'Album was successfully created.'
    page.should have_content album.title
  end
end

feature 'User destroys album' do
  let(:user) { Fabricate(:confirmed_user) }
  let!(:album) { Fabricate(:album, user: user) }

  background(:each) do
    sign_in user
  end

  scenario 'with valid info' do
    visit homepage

    click_link album.title

    click_link 'Delete'

    page.should have_content 'Album was successfully destroyed.'

    page.should have_no_content album.title
  end
end

feature 'User edits albums' do
  let(:user) { Fabricate(:confirmed_user) }
  let!(:album) { Fabricate(:album, user: user) }
  let(:edited_album) { Fabricate.build(:album) }

  background(:each) do
    sign_in user
  end

  scenario 'with valid info' do
    visit homepage

    click_link album.title

    click_link 'Edit'

    within('.edit_album') do
       fill_in 'Title', with: edited_album.title
       fill_in 'Description', with: edited_album.description
     end
     click_button 'Save'

    page.should have_content 'Album was successfully updated.'
    page.should have_content edited_album.title
  end
end
