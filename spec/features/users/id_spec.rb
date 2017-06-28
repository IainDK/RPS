require 'spec_helper'

feature "it displays a user's profile by matching the querystring with the user.id" do

  let!(:user) do
    User.create(name: 'Iain DK',
                email: 'iaindk@example.com',
                password: 'secret',
                password_confirmation: 'secret')
  end

  let!(:user2) do
    User.create(name: 'Kirsty LM',
                email: 'kirstylm@example.com',
                password: 'secret',
                password_confirmation: 'secret')
  end

  scenario 'it displays their name' do
    visit "/users/""#{user.id}"
    expect(page).to have_content "Iain DK"
  end

  scenario 'the name displayed changes depending upon the profile visited' do
    visit "/users/""#{user2.id}"
    expect(page).to have_content "Kirsty LM"
  end
end

feature "it displays the user's statistics" do

  let!(:user) do
    User.create(name: 'Kathy MK',
                email: 'kathymk@example.com',
                password: 'secret',
                password_confirmation: 'secret')
  end

  before do
    sign_in(email: user.email, password: user.password)
  end

  scenario "it displays all statistics" do
    visit "/users/""#{user.id}"
    expect(page).to have_content "Games Played Wins Draws Losses W/L Ratio Win Percentage"
  end

  scenario "when a user plays and wins a game, 'Games Played' and 'Games Won' are incremented by one" do
    click_button "New Game"
    allow_any_instance_of(Computer).to receive(:weapon).and_return(:scissors)
    choose('Rock')
    click_button "Let's do this!"
    expect(page).to have_content "Congratulations, you win!"
    visit "/users/""#{user.id}"
    table = page.find(:css, 'table')
    expect(table).to have_content('1 1 0 0 1.0 100%')
  end

  scenario "when a user plays and draws a game, 'Games Played' and 'Games Drawn' are incremented by one" do
    click_button "New Game"
    allow_any_instance_of(Computer).to receive(:weapon).and_return(:rock)
    choose('Rock')
    click_button "Let's do this!"
    expect(page).to have_content "It's a tie!"
    visit "/users/""#{user.id}"
    table = page.find(:css, 'table')
    expect(table).to have_content('1 0 1 0 0.0 0%')
  end

  scenario "when a user plays and loses a game, 'Games Played' and 'Games Lost' are incremented by one" do
    click_button "New Game"
    allow_any_instance_of(Computer).to receive(:weapon).and_return(:paper)
    choose('Rock')
    click_button "Let's do this!"
    expect(page).to have_content "You lost this time."
    visit "/users/""#{user.id}"
    table = page.find(:css, 'table')
    expect(table).to have_content('1 0 0 1 0.0 0%')
  end

  scenario "user wins, draws and loses: W/L ratio should be 1.0 = W% should be 33" do
    click_button "New Game"
    allow_any_instance_of(Computer).to receive(:weapon).and_return(:scissors)
    choose('Rock')
    click_button "Let's do this!"
    expect(page).to have_content "Congratulations, you win!"

    click_link "Play Again"
    click_button "New Game"
    allow_any_instance_of(Computer).to receive(:weapon).and_return(:rock)
    choose('Rock')
    click_button "Let's do this!"
    expect(page).to have_content "It's a tie!"

    click_link "Play Again"
    click_button "New Game"
    allow_any_instance_of(Computer).to receive(:weapon).and_return(:paper)
    choose('Rock')
    click_button "Let's do this!"
    expect(page).to have_content "You lost this time."

    visit "/users/""#{user.id}"
    table = page.find(:css, 'table')
    expect(table).to have_content('3 1 1 1 1.0 33%')
  end
end
