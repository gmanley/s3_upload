require 'acceptance_helper'

feature "User signs in" do
  let(:user) { Fabricate(:confirmed_user) }

  background do
    visit homepage
  end

  scenario "with invalid credentials" do
    within 'form#login' do
      fill_in "user_username", with: "nope"
      fill_in "user_password", with: "wrong"

      click_button "Sign In"
    end

    page.should have_content "Invalid email or password"
  end

  scenario "with valid credentials" do
    within 'form#login' do
      fill_in "user_username", with: user.username
      fill_in "user_password", with: user.password

      click_button "Sign In"
    end

    page.should have_content 'Signed in successfully.'
  end
end