class Player
  attr_reader :name
  attr_reader :char
  
  def initialize(name, char, pnumber)
    @name = name
    @char = char
    @pnumber = pnumber
  end

  def show_name
    puts "\nPlayer #{@pnumber} name: #{@name}"
  end

  def show_char
    puts "Player #{@pnumber} character: #{@char}"
  end

  def char
    return @char
  end
end