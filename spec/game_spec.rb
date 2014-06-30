require "rspec"
require 'game'

describe "::Game" do

	before(:each) do
   	@game = Game.new
   	@player1 = @game.player1
   	@computer = @game.player2
  end


	it "creates the players" do
		@game.add_players
		expect(@game.player1).to be_a Player
		expect(@game.player2).to be_a Player
	end

	it "allows player to move" do
		@player1 = Player.new(true, true)
		@game.move(@player1, 1)
		expect(@game.board.game_board[0]).to eql("X")
	end

	it "wont let you put on top of another piece" do
		@player1 = Player.new(true, true)
		@player2 = Player.new(false, false)
		@game.move(@player1, 1)
		@game.move(@player2, 1)
		expect(@game.board.game_board[0]).to eql("X")
	end

	it "only allows active player to move" do
		@player1 = Player.new(false, true)
		@game.move(@player1, 1)
		expect(@game.board.game_board[0]).to eql(1)
	end

	it "can have a piece" do
		expect(@game.player1.piece).to be_a Piece
		expect(@game.player2.piece).to be_a Piece
	end

	it "wont allow player to go out of turn" do
		@game.player1.active = false
		@game.move(@game.player1, 8)
		expect(@game.board.game_board[8]).to eql(9)
	end

	it "switches active players" do
		@game.player1.active = true
		@game.move(@game.player1, 8)
		expect(@game.player2.active).to eql(true)
		expect(@game.player1.active).to eql(false)
	end


 #  it "runs move" do
 #  	@game.turn(@game.player1)
 #  end

  it "lets me know when over" do
  		@game.board.game_board[0] = "X"
  		@game.board.game_board[1] = "X"
  		@game.board.game_board[2] = "X"
  	expect(@game.over?(@player1)).to eql(true)
  end

end



