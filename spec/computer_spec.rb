require './app/lib/computer'

describe Computer do

  let(:computer) { (Computer.new) }

  describe 'computer_weapon' do
    it "selects a random weapon for the computer from the CHOICES constant" do
      allow(computer).to receive(:computer_weapon).and_return(:rock)
      expect(computer.computer_weapon).to eq :rock
    end
  end
end
