require 'rspec'
require 'board'

describe "Board" do

	subject(:board) { Board.new }
	let(:game_board) {board.game_board}

	it "has 9 spaces" do
		expect(game_board.length).to eql(9)
		expect(game_board).to include(rand(1..9))
	end

	# it "is created on game start" do
	# 	game = Game.new
	# 	expect(game.board).to be_a Board
	# end

	it "finds the middle" do
		expect(board.middle).to eql(5)
	end

	it "finds open corners" do
		board.find_corners
		expect(board.corners).to include([1, 3, 7, 9].sample)
	end

	it "finds rows" do
		board.find_rows
		expect(board.rows[0]).to include(rand(1..3))
	end

	it "finds columns" do
		board.find_columns
		expect(board.columns[1]).to include([2, 5, 8].sample)
	end

	it "finds the diagonals" do
		board.find_diagonals
		expect(board.diagonals[0]).to include([1, 5, 9].sample)
	end
end