require 'spec_helper'

feature 'Viewing the Outcome of the game' do

  scenario 'player wins' do
    visit('/')
    fill_in :name, with: 'Iain'
    click_button "Let's play!"
    allow_any_instance_of(Computer).to receive(:weapon).and_return(:scissors)
    choose('Rock')
    click_button "Let's do this!"
    expect(page).to have_content "Congratulations, you win!"
  end

  scenario 'player loses' do
    visit('/')
    fill_in :name, with: 'Iain'
    click_button "Let's play!"
    allow_any_instance_of(Computer).to receive(:weapon).and_return(:paper)
    choose('Rock')
    click_button "Let's do this!"
    expect(page).to have_content "You lost this time."
  end

  scenario 'player draws' do
    visit('/')
    fill_in :name, with: 'Iain'
    click_button "Let's play!"
    allow_any_instance_of(Computer).to receive(:weapon).and_return(:rock)
    choose('Rock')
    click_button "Let's do this!"
    expect(page).to have_content "It's a tie!"
  end
end
