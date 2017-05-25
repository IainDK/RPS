require 'spec_helper'

feature 'Viewing the Outcome of the game' do

  let!(:user) do
    User.create(name: 'Iain',
                email: 'iain@example.com',
                password: 'blue',
                password_confirmation: 'blue')
  end

  scenario 'player wins' do
    sign_in(email: user.email, password: user.password)
    click_button "New Game"
    allow_any_instance_of(Computer).to receive(:weapon).and_return(:scissors)
    choose('Rock')
    click_button "Let's do this!"
    expect(page).to have_content "Congratulations, you win!"
  end

  scenario 'player loses' do
    sign_in(email: user.email, password: user.password)
    click_button "New Game"
    allow_any_instance_of(Computer).to receive(:weapon).and_return(:paper)
    choose('Rock')
    click_button "Let's do this!"
    expect(page).to have_content "You lost this time."
  end

  scenario 'player draws' do
    sign_in(email: user.email, password: user.password)
    click_button "New Game"
    allow_any_instance_of(Computer).to receive(:weapon).and_return(:rock)
    choose('Rock')
    click_button "Let's do this!"
    expect(page).to have_content "It's a tie!"
  end
end
