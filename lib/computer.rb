class Computer

  attr_reader :name, :weapon

  def initialize(name = "The Computer")
    @name = name
    @weapon = computer_weapon
  end

  def computer_weapon
    Game::CHOICES.sample
  end

end
