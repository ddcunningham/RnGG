require 'RnGG/game'
module RnGG
	describe Game do
	  before do
	    $stdout = StringIO.new
	    @game = Game.new("Chucklefucks")
	    @initial_health = 100
	    @player = Player.new("moe",@initial_health)
	    @game.addplayer(@player)
	  end
	    it "heals a player if a high number is rolled" do
	      Die.any_instance.stub(:roll).and_return(5)
	      @game.play
	      @player.health.should == @initial_health + 15
	    end
	    it "skips a player if a medium number is rolled" do
	      Die.any_instance.stub(:roll).and_return(3)
	      @game.play
	      @player.health.should == @initial_health
	    end
	    it "harms a player if a low number is rolled" do
	      Die.any_instance.stub(:roll).and_return(1)
	      @game.play
	      @player.health.should == @initial_health - 10
	    end
	    it "plays more than 1 round if a number > 1 is passed to .play" do
	      Die.any_instance.stub(:roll).and_return(1)
	      @game.play(2)
	      @player.health.should == @initial_health - 20
	    end
	end
end
