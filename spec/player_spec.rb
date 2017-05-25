require './app/models/player'

describe Player do

  let(:player) { (Player.new) }

  describe 'initialize' do
    it "allows the player to register their name" do
      expect(player.name).to eq "Player"
    end
  end

  describe 'player_weapon' do
    it "allows the player to select their weapon" do
      subject.player_weapon(:rock)
      expect(subject.weapon).to eq :rock
    end
  end
end
