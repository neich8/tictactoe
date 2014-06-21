require "rspec"
require 'game'

describe "::Game" do

	before(:each) do
   	@game = Game.new
   	@player1 = @game.player1
   	@computer = @game.computer
  end

	it "decides an order" do
		expect([0, 1]).to include @game.pick_order
	end

	it "creates the players" do
		@game.set_initial_order
		expect(@game.player1).to be_a Player
		expect(@game.computer).to be_a Player
	end

	it "allows a person to place piece on the board" do
		@game.player1.active = true
		@game.move(@game.player1, 1)
		expect(@game.board.game_board[1]).to eql(@player1.piece.type)
	end

	it "can have a piece" do
		expect(@player1.piece).to be_a Piece
		expect(@computer.piece).to be_a Piece
	end

	it "wont allow player to go out of turn" do
		@game.player1.active = false
		@game.move(@game.player1, 8)
		expect(@game.board.game_board[8]).to eql(9)
	end

	it "switch" do
		@game.player1.active = true
		@game.move(@game.player1, 8)
		expect(@game.computer.active).to eql(true)
	end

	it "not allowed to place over another piece" do
		@game.board.game_board[0] = "O"
  	@game.player1.active = true
  	@game.move(@game.player1, 0)
		expect(@game.board.game_board[0]).to eql("O")
  end

  it "runs move" do
  	@game.turn(@game.player1)
  	expect(@game).to have_received(@game.move)
  end

end



