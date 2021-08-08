require_relative "lib/tictactoe"

start = TicTacToe.new
start.start_player_creation
start.create_new_game(start.player_one, start.player_two)
start.game_loop(start.game)