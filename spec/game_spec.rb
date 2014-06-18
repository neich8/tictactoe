require "rspec"
require 'game'

describe "::Game" do
	subject(:game) {Game.new}
	let(:player1) {game.player1}
	let(:computer) {game.computer}
	it "decides an order" do
		expect([0, 1]).to include game.pick_order
	end

	it "creates the players" do
		game.create_players
		expect(game.player1).to be_a Player
		expect(game.computer).to be_a Player
	end
end

describe "Players" do
	game = Game.new
	game.set_initial_order
	subject(:game) {game}
	let(:player1) {game.player1}
	let(:computer) {game.computer}
	it "can have a piece" do
		expect(player1.piece).to be_a Piece
		expect(computer.piece).to be_a Piece
	end

	it "allows a person to place piece on the board" do
		game.player1.active = true
		game.move(game.player1, 1)
		expect(game.board.game_board[1]).to eql(player1.piece.type)
	end
	it "wont allow player to go out of turn" do
		game.player1.active = false
		game.move(game.player1, 8)
		expect(game.board.game_board[8]).to eql(9)
	end

	it "switch" do
		game.player1.active = true
		game.move(game.player1, 8)
		expect(game.computer.active).to eql(true)
	end
end

describe "Computer" do
	game = Game.new
	game.create_players
	game.computer.active = true
	game.move
	subject(:game) {game}
	it "picks middle spot if available" do
		expect(game.board.game_board[4]).to eql("X")
	end
end

