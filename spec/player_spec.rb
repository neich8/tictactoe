require 'rspec'
require 'player'


describe "::Player" do

  before(:each) do
   	@board = Board.new
   	@player = Player.new(true)
		@player.auto_move(@board)
  end


	it "picks middle spot if available" do

		expect(@player.board.game_board[4]).to eql("X")
	end

	it "can a piece on a corner spot if no middle spot" do
		@player.check_corners
		expect(@player.board.game_board[0]).to eql("X")
	end
	
	it "finds opposing players move" do
		@board.game_board[8] = "O"
		expect(@player.find_move).to include(8)
	end

	it "finds possible blocks" do
		@board.game_board[8] = "O"
		expect(@player.possible_blocks).to include([1, 3, 5, 6, 7, 8].sample)
	end

  it "finds what will block the most" do
  	@board.game_board[8] = "O"

  end

  it "fills blocks two in a row" do
  	@board.game_board[0] = "O"
  	@board.game_board[1] = "O"
  	@player.block_two_in_a_row
  	expect(@board.game_board[2]).to eql("X")
  end


end