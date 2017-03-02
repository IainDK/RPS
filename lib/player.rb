class Player

  attr_reader :name, :weapon

  def initialize(name = "Player")
    @name = name

  end

  def player_weapon(weapon)
    @weapon = weapon
  end
end
