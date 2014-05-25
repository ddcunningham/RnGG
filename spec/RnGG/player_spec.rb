require 'RnGG/player'
module RnGG
	describe Player do
	  before do
	    $stdout = StringIO.new
	    @health = 100
	    @name = "larry"
	    @player = Player.new(@name, @health)
	    @player.found_loot(Treasure.new(:hammer, 50))
	  end
	    it "has a capitalized name" do
	      @player.name.should == "Larry"
	    end
	    it "has a working status method" do
	      @player.to_s.should == "\n#{@player.name.ljust(15,'.')} HP: #{@health} Points: #{@player.lootpoints} Score: #{@player.score} "
	    end
	    it "has an intial health" do
	      @player.health.should == 100
	    end
	    it "computes a score as the sum of health/length of name" do
	      @player.score.should == (100 + 50)
	    end
	    it "increases health when healed" do
	      @player.heal
	      @player.health.should == @health + 15
	    end
	    it "decreases health when blammed" do
	      @player.blam
	      @player.health.should == @health - 10
	    end
	    it "can be created from a CSV string" do
	      player = Player.from_csv("larry,150")
	      player.name.should == "Larry"
	      player.health.should == 150
	    end
	    it "computes points as the sum of all loot points" do

	      @player.lootpoints.should == 50

	      @player.found_loot(Treasure.new(:crowbar, 400))
	  
	      @player.lootpoints.should == 450
	  
	      @player.found_loot(Treasure.new(:hammer, 50))

	      @player.lootpoints.should == 500
	    end
	  it "yields each found treasure and its total points" do
	    @player.found_loot(Treasure.new(:skillet, 100))
	    @player.found_loot(Treasure.new(:skillet, 100))
	    @player.found_loot(Treasure.new(:bottle, 5))
	    @player.found_loot(Treasure.new(:bottle, 5))
	    @player.found_loot(Treasure.new(:bottle, 5))
	    @player.found_loot(Treasure.new(:bottle, 5))
	    @player.found_loot(Treasure.new(:bottle, 5))
	  
	    yielded = []
	    @player.each_found_loot do |loot|
	      yielded << loot
	    end
	  
	    yielded.should == [
	      Treasure.new(:hammer, 50), 
	      Treasure.new(:skillet, 200), 
	      Treasure.new(:bottle, 25)
	    ]
	  end
	  context "health is greater than 100" do
	  before do
	    @player = Player.new("larry",150)
	  end
	    it "is strong" do 
	      @player.should be_strong
	      ##alt: expect(@player.strong?).to eq(true)
	    end
	  end
	  context "health is equal to or less than 100" do
	  before do
	    @player = Player.new("larry",100)
	  end
	    it "is not strong" do 
	      @player.should_not be_strong
	      ##alt: expect(@player.strong?).to eq(false)
	    end
	  end
	end
end
