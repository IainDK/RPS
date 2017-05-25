require './app/models/game'

describe Game do

  let(:game) { (Game.new) }

  it 'lists all available choices' do
    expect(Game::CHOICES).to eq [:rock, :paper, :scissors]
  end

  it 'lists all the possible outcomes for a game involving rock' do
    expect(Game::RESULTS[:rock][:rock]).to eq :draw
    expect(Game::RESULTS[:rock][:paper]).to eq :lose
    expect(Game::RESULTS[:rock][:scissors]).to eq :win
  end

  it 'lists all the possible outcomes for a game involving paper' do
    expect(Game::RESULTS[:paper][:rock]).to eq :win
    expect(Game::RESULTS[:paper][:paper]).to eq :draw
    expect(Game::RESULTS[:paper][:scissors]).to eq :lose
  end

  it 'lists all the possible outcomes for a game involving scissors' do
    expect(Game::RESULTS[:scissors][:rock]).to eq :lose
    expect(Game::RESULTS[:scissors][:paper]).to eq :win
    expect(Game::RESULTS[:scissors][:scissors]).to eq :draw
  end

  it "defaults the name of player_1 to 'Player 1' " do
      expect(game.player.name).to eq('Player')
  end

  it "defaults the name of player_2 to 'Computer' " do
      expect(game.computer.name).to eq 'The Computer'
  end

  describe 'outcome' do

  it "returns a draw when both players select rock" do
    allow(game.player).to receive(:weapon).and_return(:rock)
    allow(game.computer).to receive(:weapon).and_return(:rock)
    expect(game.outcome).to eq :draw
  end

  it "returns a loss when player_1 selects rock and the computer selects paper" do
    allow(game.player).to receive(:weapon).and_return(:rock)
    allow(game.computer).to receive(:weapon) { :paper }
    expect(game.outcome).to eq :lose
  end

  it "returns a win when player_1 selects rock and the computer selects scissors" do
    allow(game.player).to receive(:weapon).and_return(:rock)
    allow(game.computer).to receive(:weapon).and_return(:scissors)
    expect(game.outcome).to eq :win
  end

  it "returns a win when the player selects paper and the computer selects rock" do
    allow(game.player).to receive(:weapon).and_return(:paper)
    allow(game.computer).to receive(:weapon).and_return(:rock)
    expect(game.outcome).to eq :win
  end

  it "returns a draw when both players select paper" do
    allow(game.player).to receive(:weapon).and_return(:paper)
    allow(game.computer).to receive(:weapon).and_return(:paper)
    expect(game.outcome).to eq :draw
  end

  it "returns a loss when the player selects paper and the computer selects scissors" do
    allow(game.player).to receive(:weapon).and_return(:paper)
    allow(game.computer).to receive(:weapon).and_return(:scissors)
    expect(game.outcome).to eq :lose
  end

  it "returns a loss when the player selects scissors and the computer selects rock" do
    allow(game.player).to receive(:weapon).and_return(:scissors)
    allow(game.computer).to receive(:weapon).and_return(:rock)
    expect(game.outcome).to eq :lose
  end

  it "returns a win when the player selects scissors and the computer selects paper" do
    allow(game.player).to receive(:weapon).and_return(:scissors)
    allow(game.computer).to receive(:weapon).and_return(:paper)
    expect(game.outcome).to eq :win
  end

  it "returns a draw when both players select scissors" do
    allow(game.player).to receive(:weapon).and_return(:scissors)
    allow(game.computer).to receive(:weapon).and_return(:scissors)
    expect(game.outcome).to eq :draw
  end
 end
end
