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

	it "finds the middle" do
		expect(board.middle).to eql(5)
	end

	it "finds open corners" do
		expect(board.open_corner).to eql(1)
	end

	it "finds rows" do
		expect(board.row(0)).to include(rand(1..3))
	end

	it "finds rows with enemy pieces" do
		board.game_board[4] = "O"
		expect(board.row_search).to include([4, "O", 6].sample)
	end

	it "warns of 2 in one row" do
		board.game_board[0] = "O"
  	board.game_board[1] = "O"
		expect(board.two_in_a_row(0)).to include("ALERT")
	end

	it "finds columns" do
		expect(board.column(1)).to include([2, 5, 8].sample)
	end

	it "finds columns with enemy pieces" do
		board.game_board[4] = "O"
		expect(board.column_search).to include([2, "O", 8].sample)
	end

	it "finds the diagonals" do
		expect(board.diagonal).to include([1, 5, 9].sample)
	end

	it "finds diagonals with enemy pieces" do
		board.game_board[0] = "O"
		expect(board.diagonal_search).to include([5, 9].sample)
	end

	it "finds three in a row" do
		board.game_board[0] = "O"
  	board.game_board[4] = "O"
		board.game_board[8] = "O"
		expect(board.find_three_in_a_row).to eql(true)
	end

end