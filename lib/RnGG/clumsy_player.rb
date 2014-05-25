require_relative 'player'
module RnGG
  class ClumsyPlayer < Player
    attr_reader :healing_factor
    def initialize(name,health=100,healing_factor=2)
      super(name,health)
      @healing_factor = healing_factor
      @base_loot_points = @base_loot_points.map { |x| x / 2 } 
    end
    def found_loot(loot)
      damaged_loot = Treasure.new(loot.name, loot.points / 2.0)
      super(damaged_loot) 
    end
    def heal
      @healing_factor.times { super }
    end
  end
end
if __FILE__ == $0
  clumsy = ClumsyPlayer.new("klutz", 105, 2)
  
  hammer = Treasure.new(:hammer, 50)
  clumsy.found_loot(hammer)
  clumsy.found_loot(hammer)
  clumsy.found_loot(hammer)

  crowbar = Treasure.new(:crowbar, 400)
  clumsy.found_loot(crowbar)
  puts clumsy.health
  puts clumsy.healing_factor
  clumsy.heal
  puts clumsy.health

end
