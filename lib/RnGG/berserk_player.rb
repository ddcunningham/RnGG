require_relative "player"
module RnGG
  class BerserkPlayer < RnGG::Player
    def initialize (name,health=100)
      super(name,health)
      @heal_count = 0
    end
    def berserk? 
      @heal_count > 5
    end
    def heal
      super
      @heal_count += 1
      puts "#{name} says: \"My love for you is like a truck, berserker...\"" if berserk?
    end
    def blam
      if berserk?
        heal
      else
        super
      end
    end
  end
end

if __FILE__ == $0
  berserker = BerserkPlayer.new("berserker", 50)
  6.times { berserker.heal ; puts berserker.health }
  2.times { berserker.blam ; puts berserker.health }
end
