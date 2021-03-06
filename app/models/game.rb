require_relative 'computer'
require_relative 'user'
require_relative 'victory'

class Game

  POSSIBLE_OUTCOMES = [:win, :draw, :lose]

  CHOICES = [:rock, :paper, :scissors]

  RESULTS = { :rock     => {:rock => :draw, :paper => :lose, :scissors => :win},
              :paper    => {:rock => :win, :paper => :draw, :scissors => :lose},
              :scissors => {:rock => :lose, :paper => :win, :scissors => :draw}
            }

  attr_reader :player, :computer, :user

  def self.instance
    @game
  end

  def self.create(user)
    @game = Game.new(user)
  end

  def initialize(user, computer = Computer.new)
    @computer = computer
    @user = user
  end

  def outcome
      RESULTS[user.weapon][computer.weapon]
  end
end
