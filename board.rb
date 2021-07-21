class GameBoard
  attr_accessor :newboard
  @@current

  def initialize(player_1, player_2)
    @@newboard = [[1,2,3],[4,5,6],[7,8,9]]
    @player_1 = player_1
    @player_2 = player_2
    @@current = @player_1
  end

  public

  def show_board
    bar = "---+---+---"
    line_1 = " #{@@newboard[0][0]} | #{@@newboard[0][1]} | #{@@newboard[0][2]}"
    line_2 = " #{@@newboard[1][0]} | #{@@newboard[1][1]} | #{@@newboard[1][2]}"
    line_3 = " #{@@newboard[2][0]} | #{@@newboard[2][1]} | #{@@newboard[2][2]}"
    
    print "\n"
    puts line_1
    puts bar
    puts line_2
    puts bar
    puts line_3
    print "\n"
  end

  def cur_board
    return @@newboard
  end

  def update_board(selection, cur_player)
    if selection <= 3
      @@newboard[0][selection - 1] = cur_player
    elsif selection <= 6
      @@newboard[1][selection - 4] = cur_player
    elsif selection <= 9
      @@newboard[2][selection - 7] = cur_player
    end
  end

  def player_turn
    return @@current
  end

  def decide_player_turn
    if @@current == @player_1
      @@current = @player_2
      return true 
    else
      @@current = @player_1
      return false
    end
  end
end