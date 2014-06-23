require_relative "./pieces"
require_relative "./board"


class Player
	attr_accessor :active
	attr_reader :piece, :board
	def initialize(active)
		@active = active
		pick_piece
	end

	def pick_piece
		if @active == true && @piece == nil
			@piece = Piece.new("X")
		else
			@piece = Piece.new("O")
		end
	end

	def auto_move(board)
		@board = board	
		check_middle
	end


#AI moving Algo
	def check_middle
		if @board.middle != "X" || @board.middle != "O"
			@board.middle = @piece.type
			@board.game_board
		else
			check_corners
		end
	end

	def check_corners
		open_spot = board.open_corner
		@board.game_board.each_with_index do |spot, index|
			if spot == open_spot
				@board.game_board[index] = @piece.type
			end
		end
	end

	def possible_blocks
		@board.diagonal_search + @board.column_search + @board.row_search
	end

	def find_move
		other_piece = find_other_piece
		moves = @board.game_board.map.with_index do |spot, index|
			if spot == other_piece
				spot = index
			end
		end
		moves.compact
	end

	def block_two_in_a_row
		if @board.two_in_a_row(0).last == "ALERT"
			puts "found the alert"
			@board.two_in_a_row(0).each do |spot|
				if spot.is_a? Integer
					puts "Found the spot"
					@board.game_board[spot-1] = @piece.type
				end
			end
		end
		puts @board.game_board
	end

	private

	def find_other_piece
		if @piece.type == "X"
			"O"
		else 
			"X"
		end
	end

end


# @board = Board.new
# @player = Player.new(true)
# @player.auto_move(@board)
# @board.game_board[0] = "O"
# @board.game_board[3] = "O"
# @player.find_move
# p @board.open_corner
