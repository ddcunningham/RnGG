require_relative 'player'
require_relative 'die'
require_relative 'treasure'
module RnGG
	module GameTurn
	  def self.take_turn(player)
	    die = Die.new
	    case die.roll
	      when 1..2
	        player.blam
	      when 3..4
	        puts "#{player.name} was skipped."
	      when 5..6
	        player.heal
	      else
	        puts "OH GOD WHY IS THIS HERE I AM NOT GOOD WITH COMPUTER"
	    end
	    treasure = TreasureTrove.randomloot
	    player.found_loot(treasure)
	  end
	end
end
