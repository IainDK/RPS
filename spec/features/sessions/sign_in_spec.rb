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
    User.create(name: 'Kirsty',
                email: 'kirsty@example.com',
                password: 'orange',
                password_confirmation: 'orange')
  end

  scenario 'User can sign out' do
    sign_in(email: user.email, password: user.password)
    click_button 'Sign out'
    expect(page).to have_content('goodbye!')
    expect(current_path).to eq '/sessions/new'
  end

  scenario 'User cannot acces the sign-in page' do
    sign_in(email: user.email, password: user.password)
    visit '/sessions/new'
    expect(current_path).to eq '/'
  end

  scenario 'User cannot acces the sign-up page' do
    sign_in(email: user.email, password: user.password)
    visit '/users/new'
    expect(current_path).to eq '/'
  end

end
