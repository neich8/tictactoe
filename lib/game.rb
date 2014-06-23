require_relative "./player"
require_relative "./board"

class Game
	attr_reader :player1, :computer, :board
	def initialize
		@board = Board.new
		set_initial_order
	end

	def pick_order
		rand(2)
	end

	def set_initial_order
		if 2 == pick_order
			create_players(true, false)
			turn(@player1)
		else 
			create_players(false, true)
		end
	end

	def create_players(player_status, computer_status)
		@player1 = Player.new(player_status)
		@computer = Player.new(computer_status)
	end

	def turn(player)
		if player == @player1
			puts "Pick a spot"
			move(@player1, gets.chomp)
		else
			move(@computer)
		end
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
	def move(active_player=nil, move=nil)
		if active_player == @computer
			@computer.auto_move(@board)
		elsif active_player.active == true
			if @board.game_board[move.to_i].is_a? Integer
				@board.game_board[move] = active_player.piece.type
				deactivate_player(active_player)
			end
		else
			puts "No cheating"
		end
	end


	def over?
		@board.find_three_in_a_row
		
	end
end
