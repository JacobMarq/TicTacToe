require_relative "player"

class GameBoard
  attr_accessor :newboard, :current, :winner, :active, :player_1, :player_2

  def initialize(player_1, player_2)
    @newboard = [[1,2,3],[4,5,6],[7,8,9]]
    @player_1 = player_1
    @player_2 = player_2
    @current = @player_1
    @winner = nil
    @active = true
  end

  def set_winner(who_won)
    @winner = @player_1 if who_won == @player_1.char
    @winner = @player_2 if who_won == @player_2.char
    return @winner 
  end
  
  def win_locations
    winning_locations = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6]
    ]
    return winning_locations
  end

  def show_board
    bar = "---+---+---"
    line_1 = " #{@newboard[0][0]} | #{@newboard[0][1]} | #{@newboard[0][2]}"
    line_2 = " #{@newboard[1][0]} | #{@newboard[1][1]} | #{@newboard[1][2]}"
    line_3 = " #{@newboard[2][0]} | #{@newboard[2][1]} | #{@newboard[2][2]}"

    display = "\n#{line_1}\n#{bar}\n#{line_2}\n#{bar}\n#{line_3}\n"
    puts display
    return display
  end

  def board
    return @newboard
  end

  def update_board(selection)
    if selection <= 3
      @newboard[0][selection - 1] = @current.char
    elsif selection <= 6
      @newboard[1][selection - 4] = @current.char
    elsif selection <= 9
      @newboard[2][selection - 7] = @current.char
    end
    puts @newboard
    return @newboard
  end

  def player_turn
    return @current
  end

  def decide_player_turn
    if @current == @player_1
      @current = @player_2
    else
      @current = @player_1
    end
    return @current
  end
end