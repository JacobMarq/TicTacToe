require_relative "lib/player"
require_relative "lib/board"
require_relative "lib/displaytext"

include DisplayText

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

def initiate_game(player_one, player_two)
  new_game = GameBoard.new(player_one, player_two)
  new_game.show_board
  return new_game
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

def find_indicies(arr, value)
  arr.each_index.select {|index| arr[index] == value}
end

def check_for_winner(game)
  board = game.board
  board = board.flatten
  
  x_locations = find_indicies(board, "X")
  o_locations = find_indicies(board, "O")

  if o_locations.length < 2 || x_locations.length < 2
    return
  end

  if x_locations.length >= 3
    if board.all? {|x| x.class === "string"}
      game.winner = "Game Draw: Nobody"
    end
  end

  if game.win_locations.any? {|win_loc| (win_loc - x_locations).empty?}
    game.set_winner("X")
  elsif game.win_locations.any? {|win_loc| (win_loc - o_locations).empty?}
    game.set_winner("O")
  end

  return game.winner
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

def end_game(winner)
  winner_winner(winner)
  play_again_text
  if play_again?
    new_game = initiate_game(player_one, player_two)
    game_loop(new_game)
  else
    thank_you
  end
end

def game_loop(game)
  while game.active
    make_selection(game.player_turn.name)
    selection = confirm_selection(game)
    game.decide_player_turn

    game.update_board(selection)
    game.show_board
    
    if check_for_winner(game) != nil
      game.active = false
    end
  end
  end_game(game.winner.name)
end



player_one = create_player(1)
player_two = create_player(2, player_one.char)

player_one.show_name
player_one.show_char
player_two.show_name
player_two.show_char

current_game = initiate_game(player_one, player_two)
game_loop(current_game)