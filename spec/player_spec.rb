require 'rspec'
require 'player'


describe "::Player" do

  before(:each) do
   	@board = Board.new
   	@player = Player.new(true)

  end

  it "can be a computer or human" do
  	expect(@player.human= true).to eql(true)
	end
end

describe "Computer player" do
	before(:each) do
		@board = Board.new
		@player = Player.new(true, false)
	end

	it "checks for two in a row" do
		@board.game_board[0] = "O"
		@board.game_board[1] = "O"
		expect(Computer.two_in_a_row(@board, "O")).to eql(3)
	end

	it "checks for two in a row" do
		@board.game_board[0] = "O"
		@board.game_board[3] = "O"
		expect(Computer.two_in_a_column(@board, "O")).to eql(7)
	end

	it "checks for two in a diagonal" do
		@board.game_board[0] = "O"
		@board.game_board[4] = "O"
		expect(Computer.two_in_a_diagonal(@board, "O")).to eql(9)
	end

	it "blocks two in a row" do
		@board.game_board[0] = "O"
		@board.game_board[1] = "O"
		@player.block_two_in_a_row(@board)
		expect(@board.game_board[2]).to eql("X")
	end

	it "finds blocks for single moves" do
		@board.game_board[0] = "O"
		expect(@player.find_moves(@board)).to include([2,3,4,5,7,9].sample)
	end

	it "compares corners to possible blocks" do
		@board.game_board[2] = "O"
		expect(@player.compare_moves_corners(@board)).to include([1,7,9].sample)
	end

	it "puts in a corner and block spot if possible" do
		@board.game_board[6] = "O"
		@player.block(@board)
		expect(@board.game_board[0]).to eql("X")
	end

	it "completes three in a row" do 
		@board.game_board[6] = "X"
		@board.game_board[7] = "X"
		@player.end_game(@board)
		expect(@board.game_board[8]).to eql("X")
	end

	it "creates two in a row" do
		@board.game_board[2] = "X"
		@player.create_two(@board)
		expect(@board.game_board[0]).to eql("X")
	end

	it "makes first move in the middle" do
		@player.middle(@board)
		expect(@board.game_board[4]).to eql("X")
	end
end