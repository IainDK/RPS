feature 'Viewing Users' do

  scenario 'I can see existing users on the links page' do

    User.create(name: 'Iain')
    visit '/users'
    expect(page.status_code).to eq 200

    within 'ul#users' do
      expect(page).to have_content('Iain')
    end
  end
end
