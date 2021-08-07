class Player
  attr_accessor :name, :char
  
  def initialize(player_num, name, char)
    @player_num = player_num
    @name = name
    @char = char
  end

  def show_name
    puts "\nPlayer #{@player_num} name: #{@name}"
  end

  def show_char
    puts "Player #{@player_num} character: #{@char}"
  end
end