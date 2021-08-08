require_relative "player"

class GameBoard
  attr_accessor :board, :current, :winner, :active, :player_1, :player_2

  def initialize(player_1, player_2)
    @board = [[1,2,3],[4,5,6],[7,8,9]]
    @player_1 = player_1
    @player_2 = player_2
    @current = @player_1
    @winner = nil
    @active = true
  end

  def show_board
    bar = "---+---+---"
    line_1 = " #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]}"
    line_2 = " #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]}"
    line_3 = " #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}"

    display = "\n#{line_1}\n#{bar}\n#{line_2}\n#{bar}\n#{line_3}\n"
    puts display
    return display
  end

  def update_board(selection)
    if selection <= 3
      @board[0][selection - 1] = @current.char
    elsif selection <= 6
      @board[1][selection - 4] = @current.char
    elsif selection <= 9
      @board[2][selection - 7] = @current.char
    end
    return @board
  end

  def decide_player_turn
    if @current == @player_1
      @current = @player_2
    else
      @current = @player_1
    end
    return @current
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
  
  def set_winner(who_won)
    @winner = @player_1 if who_won == @player_1.char
    @winner = @player_2 if who_won == @player_2.char
    return @winner 
  end
  
  def find_indicies(arr, value)
    arr.each_index.select {|index| arr[index] == value}
  end
  
  def find_winner
    board = @board
    board = board.flatten
    
    x_locations = find_indicies(board, "X")
    o_locations = find_indicies(board, "O")
    
    if o_locations.length < 2 || x_locations.length < 2
      return
    end
  
    if x_locations.length >= 3 || o_locations.length >=3
      if board.all? {|x| x.class === "string"}
        @winner = Player.new(nil, "Game Draw: Nobody", nil)
      end
    end
  
    if win_locations.any? { |win_loc| (win_loc - x_locations).empty? }
      set_winner("X")
    elsif win_locations.any? { |win_loc| (win_loc - o_locations).empty? }
      set_winner("O")
    end
  
    return @winner
  end
end