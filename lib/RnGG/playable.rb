module RnGG
	module Playable
	  def heal
	    self.health += 15
	    puts "\n#{name}'s jimmies have been soothed."
	  end 
	  def blam
	    self.health -= 10
	    puts "\n#{name} just got fuckin reck'd!"
	  end
	  def strong?
	    health > 100
	  end
	end
end
