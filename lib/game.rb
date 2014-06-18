require_relative "./player"
require_relative "./board"

class Game
	attr_reader :player1, :computer, :board
	def initialize
		create_board
	end

	def pick_order
		rand(2)
	end

	def set_initial_order
		create_players
		if pick_order == 0
			@player1.active = true
			@computer.active = false
			@player1.pick_piece
			@computer.pick_piece
		else 
			@computer.active = true
			@player1.active = false
			@computer.pick_piece
			@player1.pick_piece
			@player1.piece.type
		end
	end

	def create_board
		@board = Board.new
	end

	def create_players
		@player1 = Player.new
		@computer = Player.new 
	end

	def activate_player(player)
		player.active = true

	end

	def deactivate_player(player)
		player.active = false
		if player == @player1
			activate_player(computer)
		else 
			activate_player(player1)
		end
	end
##need to move to Player Class
	def move(player=nil, move=nil)
		if player == nil && @computer.active == true
			@computer.auto_move(@board)
		elsif player.active == true
			@board.game_board[move] = player.piece.type
			deactivate_player(player)
		else
			puts "No cheating"
		end
	end


	
end


game = Game.new

game.set_initial_order

game.player1.piece

puts game.board.game_board
 game.player1.active  = false
puts game.move(game.player1, 1)
puts game.board.game_board