require_relative "./player"
require_relative "./board"

class Game
	attr_reader :player1, :player2, :board
	def initialize
		@board = Board.new
		add_players
	end

	def add_players
		if pick_first_player == 1
			activate_players(true, false)
		else
			activate_players(false,true)
		end
	end

	def move(player, spot)
		if player.active == true
			if @board.game_board[spot - 1].is_a? Integer
				@board.game_board[spot - 1] = player.piece.type
				over?
				next_player
			end
		end
	end

	def over?
		sort_board
		if three_in_a_(board.rows) == true || three_in_a_(board.columns) == true || three_in_a_(board.diagonals) == true
			true
		end
	end

	def sort_board
		@board.find_rows
		@board.find_columns
		@board.find_diagonals
	end

	private

	def three_in_a_(area)
		area.each do |row|
			if row == Array.new(3, find_player[:active].piece.type)
				return true
			end
		end
	end


	def next_player
		find_player[:active].active = false
		find_player[:inactive].active = true
	end

	def find_player
		if @player1.active == true
			{active: @player1, inactive: @player2}
		else
			{active: @player2, inactive: @player2}
		end
	end


	def activate_players(player1_status, player2_status)
		@player1 = Player.new(player1_status)
		@player2 = Player.new(player2_status)
	end

	def pick_first_player
		rand(2)
	end
end

