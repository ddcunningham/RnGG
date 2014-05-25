require_relative 'player'
require_relative 'clumsy_player'
require_relative 'berserk_player'
require_relative 'game_turn'
require_relative 'die'
require_relative 'treasure'
require 'csv'
module RnGG
  class Game
    attr_reader :title
    def initialize(title)
      @title=title.capitalize
      @players=[]
    end
    def addplayer(player)
      @players.push(player)
    end
    def play(rounds=1)
      treasures = TreasureTrove::TREASURES
      puts "\nThere are #{treasures.size} treasures to be found:"
      treasures.each do |treasure|
        puts "\nA #{treasure.name} is worth #{treasure.points} points."
      end
      puts "\nThere are #{@players.length} players in #{@title}."
      @players.each do |player|
        puts player
      end
      1.upto(rounds) do |round|
        if block_given?
          break if yield
        end
        puts "\nRound #{round}\n"
        @players.each do |player|
          GameTurn.take_turn(player) 
          puts player
        end
      end
    end
    def print_nameandhealth(player, string)
      if string.length > 0
        puts "#{player.name} #{string} #{player.health} HP."
      else
        puts "#{player.name.ljust(20,'.')} #{player.health} HP."
      end
    end
    def playerscore(player)
        "\n#{player.name.ljust(20,'.')} #{player.score} points"
    end
    def playerscore_breakdown(player)
        puts "#{player.health} from health."
        player.each_found_loot { |loot| puts "#{loot.points} from #{loot.name}s." }
    end
    def total_points
      @players.reduce(0) { |sum, player| sum + player.lootpoints }
    end
    def print_stats
      strong, weak = @players.partition { |p| p.strong? }
      puts "\n#{@title} Statistics:"
      puts "\nStrong Players:" if strong.size > 0
      strong.each do |player|
        print_nameandhealth(player,"is in hearty condition with")
      end
      puts "\nWeak Players:" if weak.size > 0 
      weak.each do |player|
        print_nameandhealth(player,"is in a sickly state with")
      end
      puts "\n#{@title} Game Results:" 
      @players.each { |player| puts playerscore(player) ; playerscore_breakdown(player) }
    end
    def load_players(filename)
  ## from_csv player class method obsolete thanks to the below
      CSV.foreach(filename) do |row|
        player = Player.new(row[0], row[1].to_i)
        addplayer(player)
      end
    end
    def save_high_scores(filename="high_scores.txt")
      File.open(filename, "w") do |file|
        file.puts "#{@title} High Scores:"
        @players.sort.each { |player| file.puts playerscore(player) }
      end
    end
  end
end

