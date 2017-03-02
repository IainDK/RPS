require 'spec_helper'

feature 'Enter Name' do
  scenario 'it remembers your name' do
    visit('/')
    fill_in :name, with: 'Iain'
    click_button "Let's play!"
    expect(page).to have_content 'Okay Iain'
  end

end
