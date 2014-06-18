require 'rspec'
require 'game'

describe "Board" do

	subject(:board) { Board.new }
	let(:game_board) {board.game_board}

	it "has 9 spaces" do
		expect(game_board.length).to eql(9)
		expect(game_board).to include(rand(1..9))
	end

	it "is created on game start" do
		game = Game.new
		expect(game.board).to be_a Board
	end
end