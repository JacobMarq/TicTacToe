require_relative "../lib/player"
require_relative "../lib/board"
require_relative "../lib/displaytext"
require_relative "../lib/tictactoe"

describe TicTacToe do
    subject(:player1) { Player.new(1, 'John', 'X') }
    subject(:player2) { Player.new(2, 'Jane', 'O') }
    subject(:game) { GameBoard.new(player1, player2) }
    subject(:tictactoe) { described_class.new }
    
    describe '#start_player_creation' do
        it 'creates players displaying thier names and characters' do
            allow(tictactoe).to receive(:create_player).and_return(player1, player2)
            expect(player1).to receive(:show_name)
            tictactoe.start_player_creation
        end
    end
    
    describe '#char_selection' do
        context "with input of 'x' or 'o'" do
            it 'returns the chosen character' do
                allow(tictactoe).to receive(:gets).and_return('x')
                char = tictactoe.char_selection
                expect(char).to eql('X')
            end
        end

        context "with invalid input" do
            it 'throws error' do
                allow(tictactoe).to receive(:gets).and_return('r', 'x')
                expect(tictactoe).to receive(:char_error)
                tictactoe.char_selection
            end
        end
    end
    
    describe '#create_player' do
        context 'player 1 proper input' do
            it 'creates player 1 with formatted name' do
                allow(tictactoe).to receive(:gets).and_return('john')
                allow(tictactoe).to receive(:char_selection).and_return('X')
                expect(Player).to receive(:new).with(1, 'John', 'X')
                tictactoe.create_player(1)
            end
        end
            
        context 'player 2 proper input' do
            it 'creates player 2 with formatted name' do
                allow(tictactoe).to receive(:gets).and_return('jane')
                expect(Player).to receive(:new).with(2, 'Jane', 'O')
                tictactoe.create_player(2, 'X')
            end
        end
    end

    describe '#create_new_game' do
        it 'creates a new gameboard' do
            expect(GameBoard).to receive(:new).with(player1, player2)
            tictactoe.create_new_game(player1, player2)
        end
    end

    describe '#confirm_selection' do
        context 'made selection less than 1 or greater than 9' do
            it 'throws error' do
                allow(tictactoe).to receive(:gets).and_return('0', '10', '1')
                expect(tictactoe).to receive(:error_invalid_sel).twice
                tictactoe.confirm_selection(game)
            end

            it 'requests new selection be made' do
                allow(tictactoe).to receive(:gets).and_return('0', '10', '1')
                expect(tictactoe).to receive(:make_new_sel).twice
                tictactoe.confirm_selection(game)
            end
        end

        context 'selection is taken' do
            before do
                taken = [['X','O','X'],['X','O','X'],['O','X',9]]
                game.instance_variable_set(:@board, taken)
            end

            it 'throws error' do
                allow(tictactoe).to receive(:gets).and_return('2', '9')
                expect(tictactoe).to receive(:error_taken)
                tictactoe.confirm_selection(game)
            end

            it 'requests new selection be made' do
                allow(tictactoe).to receive(:gets).and_return('2', '9')
                expect(tictactoe).to receive(:make_new_sel)
                tictactoe.confirm_selection(game)
            end
        end

        context 'valid selection made' do
            it 'returns the given selection' do
                allow(tictactoe).to receive(:gets).and_return('2')
                expect(tictactoe).to receive(:confirm_selection).with(game).and_return('2')
                tictactoe.confirm_selection(game)
            end
        end
    end

    describe '#play_again?' do
        context 'yes' do
            it 'returns true' do
                allow(tictactoe).to receive(:gets).and_return('yes')
                expect(tictactoe.play_again?).to eql(true)
            end
        end

        context 'no' do
            it 'returns false' do
                allow(tictactoe).to receive(:gets).and_return('no')
                expect(tictactoe.play_again?).to eql(false)
            end
        end

        context "neither 'yes' or 'no'" do
            it 'throws error' do
                allow(tictactoe).to receive(:gets).and_return('maybe', 'yes')
                expect(tictactoe).to receive(:error_invalid_answer).once
                tictactoe.play_again?
            end
        end
    end

    describe '#end_game' do
        before :each do
            game.instance_variable_set(:@winner, player1)
        end
        
        it 'display winner message' do
            allow(tictactoe).to receive(:play_again?).and_return(false)
            expect(tictactoe).to receive(:winner_winner).with(game.winner.name)
            tictactoe.end_game(game)
        end
        
        context 'play again? returns true' do
            it 'begins game_loop with new game' do
                new_game = GameBoard.new(player1, player2)

                allow(tictactoe).to receive(:play_again?).and_return(true)
                allow(tictactoe).to receive(:create_new_game).and_return(new_game)
                expect(tictactoe).to receive(:game_loop).with(new_game)
                tictactoe.end_game(game)
            end
        end

        context 'play again? returns false' do
            it 'display thank you message to player' do
                allow(tictactoe).to receive(:play_again?).and_return(false)
                expect(tictactoe).to receive(:thank_you)
                tictactoe.end_game(game)
            end
        end
    end

    describe '#game_loop' do
        context 'while active' do
            before do
                game.instance_variable_set(:@winner, player1)
            end
            
            it 'takes a player selection' do
                expect(tictactoe).to receive(:confirm_selection).and_return(2)
                allow(game).to receive(:find_winner).and_return(player1)
                allow(tictactoe).to receive(:end_game).and_return(nil)
                tictactoe.game_loop(game)
            end

            it 'changes the player turn' do
                allow(tictactoe).to receive(:confirm_selection).and_return(2)
                expect(game).to receive(:decide_player_turn)
                allow(game).to receive(:find_winner).and_return(player1)
                allow(tictactoe).to receive(:end_game).and_return(nil)
                tictactoe.game_loop(game)
            end

            it 'updates the board based on player selection' do
                allow(tictactoe).to receive(:confirm_selection).and_return(2)
                expect(game).to receive(:update_board)
                allow(game).to receive(:find_winner).and_return(player1)
                allow(tictactoe).to receive(:end_game).and_return(nil)
                tictactoe.game_loop(game)
            end

            it 'checks if the game is over' do
                allow(tictactoe).to receive(:confirm_selection).and_return(2)
                expect(game).to receive(:find_winner).and_return(player1)
                allow(tictactoe).to receive(:end_game).and_return(nil)
                tictactoe.game_loop(game)
            end
        end

        context 'not active' do
            before do
                game.instance_variable_set(:@active, false)
            end

            it 'exits the game loop ending the game' do
                expect(tictactoe).to receive(:end_game).and_return(nil)
                tictactoe.game_loop(game)
            end
        end
    end
end