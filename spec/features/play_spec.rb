require 'spec_helper'

feature 'Choose move' do
  scenario 'tells you what you chose' do
    visit('/')
    fill_in :name, with: 'Iain'
    click_button "Let's play!"
    choose('Rock')
    click_button "Let's do this!"
    expect(page).to have_content 'Iain chose Rock'
  end

end
