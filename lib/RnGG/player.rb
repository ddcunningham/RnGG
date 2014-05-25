require_relative 'treasure' 
require_relative 'playable'
module RnGG
	class Player
	  include Playable
	  attr_accessor :name, :health
	  def initialize(name,health=100)
	    @base_loot_points = [5, 25, 50, 100, 200, 400 ]
	    @name = name.capitalize
	    @health = health
	    @found_loot = Hash.new(0) 
	  end
	  def to_s
	    "\n#{@name.ljust(15,'.')} HP: #{@health} Points: #{lootpoints} Score: #{score} "
	  end
	  def <=>(other)
	    other.score <=> score
	  end 
	  def self.from_csv(string)
	      name, health = string.split(',')
	      Player.new(name, Integer(health))
	  end
	  def score
	    @health + lootpoints
	  end
	  def name=(newname)
	    @name= newname.capitalize
	  end
	  def found_loot(loot)
	    @found_loot[loot.name] += loot.points
	    puts "\n#{@name} found a #{loot.name} worth #{loot.points} points."
	    puts "\n#{@name}'s stash (#{lootpoints} points):"
	    @found_loot.each do |foundloot, points|
	      case foundloot
	        when :pie
	          lootnumber = points / @base_loot_points[0]
	        when :bottle
	          lootnumber = points / @base_loot_points[1]
	        when :hammer
	          lootnumber = points / @base_loot_points[2]
	        when :skillet
	          lootnumber = points / @base_loot_points[3]
	        when :broomstick
	          lootnumber = points / @base_loot_points[4]
	        when :crowbar
	          lootnumber = points / @base_loot_points[5]
	      end
	      if lootnumber > 1
	        puts "#{lootnumber} #{foundloot}s totalling #{points} points."
	      else 
	        puts "#{lootnumber} #{foundloot} totalling #{points} points."
	      end
	    end
	  end
	  def each_found_loot
	    @found_loot.each do |name, points|
	      yield Treasure.new(name, points)
	    end
	  end
	  def lootpoints
	    @found_loot.values.reduce(0, :+)
	  end
	end
end

	if __FILE__ == $0
	player = player.new("moe")
	puts player.name
	puts player.health
	player.heal
	puts player.health
	player.blam
	puts player.health
	end
