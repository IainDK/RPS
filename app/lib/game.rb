require_relative 'player'
require_relative 'computer'

class Game

  POSSIBLE_OUTCOMES = [:win, :draw, :lose]

  CHOICES = [:rock, :paper, :scissors]

  RESULTS = { :rock     => {:rock => :draw, :paper => :lose, :scissors => :win},
              :paper    => {:rock => :win, :paper => :draw, :scissors => :lose},
              :scissors => {:rock => :lose, :paper => :win, :scissors => :draw}
            }

  attr_reader :player, :computer

  def self.instance
    @game
  end

  def self.create(player)
    @game = Game.new(player)
  end

  def initialize(player = Player.new, computer = Computer.new)
    @player = player
    @computer = computer
  end

  def outcome
    RESULTS[player.weapon][computer.weapon]
  end
end
