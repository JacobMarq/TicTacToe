require_relative "lib/player"
require_relative "lib/board"
require_relative "lib/displaytext"
require_relative "lib/winningboard"

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

enter_name_one
p_one_name = gets.chomp.capitalize
choose_char
p_one_char = char_selection
$player_one = Player.new(p_one_name, p_one_char, "1")

enter_name_two
p_two_name = gets.chomp.capitalize
if p_one_char == "X"
  p_two_char = "O"
else
  p_two_char = "X" 
end
$player_two = Player.new(p_two_name, p_two_char, "2")

$player_one.show_name
$player_one.show_char
$player_two.show_name
$player_two.show_char

def initiate_game
  $game_board = GameBoard.new($player_one.name, $player_two.name)
  $game_board.show_board
  $wins = nil
  $game_active = true
end

def confirm_selection
  board_arr = $game_board.cur_board
  board_arr = board_arr.flatten

  selection = gets.chomp.to_i

  if selection < 1 || selection > 9
    error_invalid_sel
    make_new_sel
    confirm_selection
  elsif board_arr[selection - 1].class === "string"
    error_taken
    make_new_sel
    confirm_selection
  else
    return selection
  end
end

def whos_turn(cur)
  if cur
    $player_one.char
  else
    $player_two.char
  end
end

def find_indicies(arr, value)
  arr.each_index.select {|index| arr[index] == value}
end

def check_for_winner
  board_arr = $game_board.cur_board
  board_arr = board_arr.flatten
  
  #{checks the current board for X's or O's at any of the winning sets of inidicies}
  cur_x_arr = find_indicies(board_arr, "X")
  cur_o_arr = find_indicies(board_arr, "O")

  if cur_o_arr.length < 2 || cur_x_arr.length < 2
    return
  end

  if cur_x_arr.length >= 3
    if board_arr.all? {|x| x.class === "string"}
      $wins = "Game Draw: Nobody"
    end
  end

  if $win_board.any? {|arr| (arr - cur_x_arr).empty?}
    if $player_one.char == "X"
      set_winner($player_one.name)
    else
      set_winner($player_two.name)
    end
  elsif $win_board.any? {|arr| (arr - cur_o_arr).empty?}
    if $player_one.char == "O"
      set_winner($player_one.name)
    else
      set_winner($player_two.name)
    end
  else
    return
  end
end

def set_winner(player)
  $wins = player
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

def end_game
  winner_winner($wins)
  play_again_text
  if play_again?
    initiate_game
    game_loop
  else
    thank_you
  end
end

def game_loop
  while $game_active
    make_selection($game_board.player_turn)
    turn_sel = confirm_selection
    player_turn = whos_turn($game_board.decide_player_turn)

    $game_board.update_board(turn_sel, player_turn)
    check_for_winner
    $game_board.show_board
    
    if $wins != nil
      $game_active = false
    end
  end
  end_game
end

initiate_game
game_loop