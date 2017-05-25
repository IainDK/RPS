require 'spec_helper'

feature 'Choose move' do

  let!(:user) do
    User.create(name: 'Iain',
                email: 'iain@example.com',
                password: 'blue',
                password_confirmation: 'blue')
  end

  scenario 'tells you what you chose' do
    sign_in(email: user.email, password: user.password)
    click_button "New Game"
    choose('Rock')
    click_button "Let's do this!"
    expect(page).to have_content 'You chose Rock'
  end

end
