require_relative "player"
require_relative "board"
require_relative "displaytext"
require_relative "consoleinterface"

include DisplayText

class TicTacToe
  attr_accessor :player_one, :player_two, :game, :input, :output

  def initialize()
    @player_one = nil
    @player_two = nil

    @game = nil
  end

  def start_player_creation
    @player_one = create_player(1)
    @player_two = create_player(2, @player_one.char)

    @player_one.show_name
    @player_one.show_char
    @player_two.show_name
    @player_two.show_char
  end
  
  def char_selection
    char = gets.chomp.upcase
    if char == 'X' or char == 'O'
      return char
    else
      char_error
      char_selection
    end
  end

  def create_player(num, char = nil)
    if num == 1
      enter_name_one
      name = gets.chomp.capitalize
      choose_char
      char = char_selection
    else
      enter_name_two
      name = gets.chomp.capitalize
      if char == "X"
        char = "O"
      else
        char = "X" 
      end
    end
    
    player = Player.new(num, name, char)
    return player
  end

  def create_new_game(player_one, player_two)
    @game = GameBoard.new(player_one, player_two)
  end

  def confirm_selection(game)
    board = game.board
    board = board.flatten

    selection = gets.chomp.to_i

    if selection < 1 || selection > 9
      error_invalid_sel
      make_new_sel
      confirm_selection(game)
    elsif board[selection - 1].class === "string"
      error_taken
      make_new_sel
      confirm_selection(game)
    else
      return selection
    end
  end

  def play_again?
    again = gets.chomp
    again.downcase!
    if again === "yes"
      return true
    elsif again === "no"
      return false
    else
      error_invalid_answer
      play_again?
    end
  end

  def end_game(game)
    winner_winner(game.winner.name)
    play_again_text
    if play_again?
      new_game = create_new_game(game.player_1, game.player_2)
      game_loop(new_game)
    else
      thank_you
    end
  end

  def game_loop(game)
    while game.active
      game.show_board
      make_selection(game.current.name)
      selection = confirm_selection(game)
      game.decide_player_turn

      game.update_board(selection)
      
      if game.find_winner != nil
        game.show_board
        game.active = false
      end
    end
    end_game(game)
  end
end