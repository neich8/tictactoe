require_relative "./pieces"
require_relative "./board"
require_relative "./computer_module"
class Player 


	attr_accessor :active, :human
	attr_reader :piece, :board, :opposing_piece
	def initialize(active, human_status)
		@active = active
		pick_piece
		@human = human_status
	end

	def pick_piece
		if @active == true && @piece == nil
			@piece = Piece.new("X")
			@opposing_piece = "O"
		else
			@piece = Piece.new("O")
			@opposing_piece = "X"
		end
	end

	def block_two_in_a_row(board, piece= @opposing_piece)
		blocks = []
		if Computer.two_in_a_row(board, piece).is_a? Integer
			blocks << Computer.two_in_a_row(board, piece)
		elsif Computer.two_in_a_column(board, piece).is_a? Integer
			blocks << Computer.two_in_a_column(board, piece)
		elsif Computer.two_in_a_diagonal(board, piece).is_a? Integer
			blocks << Computer.two_in_a_diagonal(board, piece)
		end
		board.game_board[blocks[0] - 1] = @piece.type
	end

	def block(board)
		board.game_board[(compare_moves_corners(board).first - 1)] = piece.type
	end

	def create_two(board)
		board.game_board[find_moves(board, piece.type).first - 1] = piece.type
	end

	def middle(board)
		if board.game_board[4].is_a? Integer
			board.game_board[4] = piece.type
		end
	end

	def find_moves(board, piece=@opposing_piece)
		moves = []
			moves << Computer.row_includes?(board, piece)
			moves << Computer.column_includes?(board, piece)
			moves << Computer.diagonal_includes?(board, piece)
		moves.flatten!.sort
	end

	def compare_moves_corners(board)
		board.find_corners
		find_moves(board).select {|spot| board.corners.include? spot}
	end

	def end_game(board)
		block_two_in_a_row(board, @piece.type)
	end

end


@player = Player.new(true, true)
@player.active = false
puts @player.human
@player.active = true
puts @player.human
@board = Board.new
# @board.game_board[6] = "O"
# @board.game_board[7] = "O"
# @player.block_two_in_a_row(@board)

# @board = Board.new
# @player = Player.new(true)
# @player.auto_move(@board)
# @board.game_board[0] = "O"
# @board.game_board[3] = "O"
# @player.find_move
# p @board.open_corner









# 	def auto_move(board)
# 		@board = board	
# 		check_middle
# 	end


# #AI moving Algo
# 	def check_middle
# 		if @board.middle != "X" || @board.middle != "O"
# 			@board.middle = @piece.type
# 			@board.game_board
# 		else
# 			check_corners
# 		end
# 	end

# 	def check_corners
# 		open_spot = board.open_corner
# 		@board.game_board.each_with_index do |spot, index|
# 			if spot == open_spot
# 				@board.game_board[index] = @piece.type
# 			end
# 		end
# 	end

# 	def possible_blocks
# 		@board.diagonal_search + @board.column_search + @board.row_search
# 	end

# 	def find_move
# 		other_piece = find_other_piece
# 		moves = @board.game_board.map.with_index do |spot, index|
# 			if spot == other_piece
# 				spot = index
# 			end
# 		end
# 		moves.compact
# 	end

# 	def block_two_in_a_row
# 		if @board.two_in_a_row(0).last == "ALERT"
# 			puts "found the alert"
# 			@board.two_in_a_row(0).each do |spot|
# 				if spot.is_a? Integer
# 					puts "Found the spot"
# 					@board.game_board[spot-1] = @piece.type
# 				end
# 			end
# 		end
# 		puts @board.game_board
# 	end

# 	private

# 	def find_other_piece
# 		if @piece.type == "X"
# 			"O"
# 		else 
# 			"X"
# 		end
# 	end
