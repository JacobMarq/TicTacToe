require '../lib/board'
require '../lib/player'

describe GameBoard do
    subject(:player1) {Player.new(1, 'doe', 'x')}
    subject(:player2) {Player.new(2, 'appleseed', 'o')}
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
        it "places an 'x' or 'o' on the first row" do
            x_on_3 = [[1,2,'x'],[4,5,6],[7,8,9]]

            expect(game.update_board(3, 'x')).to eql(x_on_3)
        end
        
        it "places an 'x' or 'o' on the second row" do
            o_on_5 = [[1,2,3],[4,'o',6],[7,8,9]]

            expect(game.update_board(5, 'o')).to eql(o_on_5)
        end
        
        it "places an 'x' or 'o' on the last row" do
            x_on_7 = [[1,2,3],[4,5,6],['x',8,9]]

            expect(game.update_board(7, 'x')).to eql(x_on_7)
        end
    end

    describe '#player_turn' do
        it 'returns the current player' do
            expect(game.player_turn).to eql(player1)
        end
    end

    describe '#decide_player_turn' do
        it "determines who's turn it will be" do
            expect(game.decide_player_turn).to eql(player2)
        end
    end
end