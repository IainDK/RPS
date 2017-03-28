require 'spec_helper'

  feature 'Sign Up' do

    scenario 'I can see a form that allows me to sign up' do
      visit 'users/new'
      expect(page.status_code).to eq(200)
      expect(page).to have_content("Please sign up")
      expect(page).to have_content("Name:")
      expect(page).to have_content("Email:")
      expect(page).to have_content("Password:")
      expect(page).to have_content("Confirm Password:")
    end

    scenario 'I can sign up using the form' do
      visit '/users/new'
      fill_in :email, with: 'iain@example.com'
      fill_in :name, with: 'Iain'
      fill_in :password, with: 'blue'
      fill_in :password_confirmation, with: 'blue'
      click_button 'Sign Up'
      expect(page.status_code).to eq(200)
      expect(User.count).to eq 1
      expect(page).to have_content 'Welcome, Iain'
      expect(User.first.email).to eq('iain@example.com')
    end

    scenario 'An error is displayed if both passwords do not match' do
      visit '/users/new'
      fill_in :email, with: 'iain@example.com'
      fill_in :name, with: 'Iain'
      fill_in :password, with: 'blue'
      fill_in :password_confirmation, with: 'red'
      click_button 'Sign Up'
      expect(User.count).to eq 0
      expect(current_path).to eq('/users')
      expect(page).to have_content 'Password does not match the confirmation'
    end

    scenario 'I can not sign up with a blank email address' do
      visit '/users/new'
      fill_in :email, with: nil
      fill_in :name, with: 'Iain'
      fill_in :password, with: 'blue'
      fill_in :password_confirmation, with: 'blue'
      click_button 'Sign Up'
      expect(User.count).to eq 0
      expect(current_path).to eq('/users')
    end

    scenario 'When signing up, a valid email format must be used' do
      visit '/users/new'
      fill_in :email, with: 'hello@invalid'
      fill_in :name, with: 'Iain'
      fill_in :password, with: 'blue'
      fill_in :password_confirmation, with: 'blue'
      click_button 'Sign Up'
      expect(User.count).to eq 0
      expect(page).to have_content 'Email has an invalid format'
      expect(current_path).to eq('/users')
    end

    scenario 'When signing up, the email address used must be unique' do
      visit '/users/new'
      fill_in :email, with: 'iain@example.com'
      fill_in :name, with: 'Iain'
      fill_in :password, with: 'blue'
      fill_in :password_confirmation, with: 'blue'
      click_button 'Sign Up'
      visit '/users/new'
      fill_in :email, with: 'iain@example.com'
      fill_in :name, with: 'Iain'
      fill_in :password, with: 'blue'
      fill_in :password_confirmation, with: 'blue'
      click_button 'Sign Up'
      expect(User.count).to eq 1
      expect(page).to have_content 'Email is already taken'
    end

  end

  feature 'User sign in' do

  let!(:user) do
    User.create(name: 'Iain',
                email: 'iain@example.com',
                password: 'blue',
                password_confirmation: 'blue')
    end

    scenario 'with correct credentials' do
      sign_in(email: user.email, password: user.password)
      expect(page).to have_content "Welcome, #{user.name}"
    end
  end

  feature 'User signs out' do

  before(:each) do
    User.create(email: 'test@test.com',
                password: 'test',
                password_confirmation: 'test')
  end

  scenario 'while being signed in' do
    sign_in(email: 'test@test.com', password: 'test')
    click_button 'Sign out'
    expect(page).to have_content('goodbye!')
    expect(page).not_to have_content('Welcome, test@test.com')
  end

end
