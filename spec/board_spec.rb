require '../lib/board'
require '../lib/player'

describe GameBoard do
    subject(:player1) {Player.new(1, 'doe', 'X')}
    subject(:player2) {Player.new(2, 'appleseed', 'O')}
    subject(:game) { described_class.new(player1, player2) }

    describe '#show_board' do
        it 'displays current state of the board' do
            display = "\n 1 | 2 | 3\n---+---+---\n 4 | 5 | 6\n---+---+---\n 7 | 8 | 9\n"
            expect(game.show_board).to eql(display)
        end
    end

    describe '#board' do
        it 'returns the current state of the board' do
            expect(game.board).to eql([[1,2,3],[4,5,6],[7,8,9]])
        end
    end

    describe '#update_board' do
        it "places an 'X' or 'O' on the given location" do
            x_on_3 = [[1,2,'X'],[4,5,6],[7,8,9]]

            expect(game.update_board(3)).to eql(x_on_3)
        end
    end

    describe '#decide_player_turn' do
        it "determines who's turn it will be" do
            expect(game.decide_player_turn).to eql(player2)
        end
    end

    describe '#win_locations' do
        it 'returns the winning location combinations' do
            winning_loc = [
                [0,1,2],
                [3,4,5],
                [6,7,8],
                [0,3,6],
                [1,4,7],
                [2,5,8],
                [0,4,8],
                [2,4,6]
              ]

            expect(game.win_locations).to eql(winning_loc)
        end
    end

    describe '#set_winner' do
        it 'updates the game winner variable' do
            expect(game.set_winner('X')).to eql(player1)
        end
    end

    describe '#find_indicies' do
        it 'finds all indicies of a given value within an array' do
            array = [0,1,2,'X',4,'X']
            
            expect(game.find_indicies(array, 'X')).to eql([3,5])
        end
    end

    describe '#find_winner' do
        it 'finds the game winner if there is one' do
            expect(game.find_winner).to eql(nil)
        end

        context 'tie' do
            before do
                array = [['X','O','X'],['X','O','X'],['O','X','O']]
                game.instance_variable_set(:@board, array)
            end

            it 'declares game draw' do
                game.find_winner
                expect(game.winner.name).to eql("Game Draw: Nobody")
            end
        end
        
        context 'horizontal win' do
            before do
                chicken_dinner = [['X','X','X'],['O',5,'O'],[7,8,9]]
                game.instance_variable_set(:@board, chicken_dinner)
            end

            it 'finds winner with horizontal victory' do
                game.find_winner
                expect(game.winner).to eql(player1)
            end
        end

        context 'vertical win' do
            before do
                chicken_dinner = [['X','O','O'],['X',5,'O'],['X',8,9]]
                game.instance_variable_set(:@board, chicken_dinner)
            end

            it 'finds winner with vertical victory' do
                game.find_winner
                expect(game.winner).to eql(player1)
            end
        end

        context 'diagonal win' do
            before do
                chicken_dinner = [['X','O','O'],['X','O','X'],['O',8,9]]
                game.instance_variable_set(:@board, chicken_dinner)
            end

            it 'finds winner with diagonal victory' do
                game.find_winner
                expect(game.winner).to eql(player2)
            end
        end
    end
end