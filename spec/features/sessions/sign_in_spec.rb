require 'spec_helper'

feature 'User sign in' do

  let!(:user) do
    User.create(name: 'Iain',
                email: 'iain@example.com',
                password: 'blue',
                password_confirmation: 'blue')
  end

    scenario 'with correct credentials' do
      sign_in(email: user.email, password: user.password)
      expect(current_path).to eq '/'
    end

    scenario 'with incorrect email' do
      sign_in(email: 'iain@example.co.uk', password: user.password)
      expect(current_path).to eq '/sessions'
      expect(page).to have_content 'The email or password is incorrect.'
    end

    scenario 'with incorrect password' do
      sign_in(email: user.email, password: 'red')
      expect(current_path).to eq '/sessions'
      expect(page).to have_content 'The email or password is incorrect.'
    end
  end

feature 'Whilst signed in' do

  let!(:user) do
    User.create(name: 'Kirsty M',
                email: 'kirsty@example.com',
                password: 'orange',
                password_confirmation: 'orange')
  end

  before do
      sign_in(email: user.email, password: user.password)
  end

  scenario 'User can access the nav bar' do
    expect(page).to have_content "RPS"
    expect(page).to have_content "Kirsty M"
    expect(page).to have_content "Sign Out"
  end

  scenario 'User can return to the home page' do
    click_link 'RPS'
    expect(current_path).to eq '/'
  end

  scenario 'User can view their own profile' do
    click_link 'Kirsty M'
    expect(current_path).to eq "/users/""#{user.id}"
  end

  scenario 'User can sign out' do
    click_link 'Sign Out'
    expect(current_path).to eq '/sessions/new'
  end

  scenario 'User cannot acces the sign-in page' do
    visit '/sessions/new'
    expect(current_path).to eq '/'
  end

  scenario 'User cannot acces the sign-up page' do
    visit '/users/new'
    expect(current_path).to eq '/'
  end
end
