describe User do

  let!(:user) do
    User.create(name: 'Iain K', email: 'test@test.com', password: 'secret1234',
               password_confirmation: 'secret1234')
  end

  it 'authenticates when given a valid email address and password' do
    authenticated_user = User.authenticate(user.email, user.password)
    expect(authenticated_user).to eq user
  end

  it 'does not authenticate when given an incorrect password' do
    expect(User.authenticate(user.email, 'wrong_password')).to be_nil
  end

  describe 'user_weapon' do

    it "allows the user to select their weapon" do
      user.user_weapon(:rock)
      expect(user.weapon).to eq :rock
    end
  end

  describe 'first_name' do

    it "should display the user's first name" do
      expect(user.first_name).to eq 'Iain'
    end
  end

end
