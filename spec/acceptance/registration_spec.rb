require 'acceptance_helper'

feature "User registers an account" do
  let(:user) { Fabricate.build(:user) }

  background do
    visit homepage
  end

  scenario "with valid information" do
    click_link 'Sign Up'

    within('form') do
      fill_in "user_username", with: user.username
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: user.password

      click_button "Sign Up"
    end

    page.should have_content "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
  end
end
