require_relative "./pieces"
require_relative "./board"
require_relative "./computer_module"
require "byebug"
#The computer doesnt know when to stop putting pieces on the board
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

	def ai_move(board)
		if end_game(board).is_a? Integer
			return end_game(board)
		elsif middle(board).is_a? Integer
			return middle(board)
		elsif block_two_way_lose(board).is_a? Integer
			return block_two_way_lose(board)
		elsif block_two_in_a_row(board)[0].is_a? Integer
			return block_two_in_a_row(board)[0]
		elsif block(board).is_a? Integer
			return block(board)
		elsif create_two(board).is_a? Integer
			return create_two(board)
		end
	end

	def block_two_in_a_row(board, piece= @opposing_piece)
		blocks = []

		if Computer.two_in_a_row(board, piece)
			blocks << Computer.two_in_a_row(board, piece)
		end
		if Computer.two_in_a_column(board, piece)
			blocks << Computer.two_in_a_column(board, piece)
		end
		if Computer.two_in_a_diagonal(board, piece)
			blocks << Computer.two_in_a_diagonal(board, piece)
		end
		blocks.flatten
	end

	def block(board)
		if compare_moves_corners(board).length > 0
			compare_moves_corners(board).sample
			# compare_moves_corners(board).max_by{|num| num.size}
		end
	end
#board adds pieces two create two in a row even if two in a row is not possible
	def create_two(board)
		if find_moves(board, piece.type).length != 0 

			find_moves(board, piece.type).max_by{|num| num.size}
		end
	end

	def middle(board)
		if board.game_board[4].is_a? Integer
			board.game_board[4]
		end
	end

	def find_moves(board, piece=@opposing_piece)
		moves = []
			moves << Computer.row_includes?(board, piece)
			moves << Computer.column_includes?(board, piece)
			moves << Computer.diagonal_includes?(board, piece)

		moves.flatten!
	end

	def compare_moves_corners(board)
		board.find_corners
		find_moves(board).select {|spot| board.corners.include? spot}
	end

	def end_game(board)
		block_two_in_a_row(board, @piece.type)[0]
	end

	def find_possible_two_ways(board, piece= @opposing_piece)
		possible_two_ways = []
		temp_board = board
		temp_board.game_board.each do |spot|
			if spot.is_a? Integer
				temp_board.game_board[spot -1] = piece
					if block_two_in_a_row(temp_board, piece).length > 0
						possible_two_ways << block_two_in_a_row(temp_board, piece)
					end
					temp_board.game_board[spot -1] = spot
			end
		end
		count(possible_two_ways)
	end

	def block_two_way_lose(board, piece = @opposing_piece)

		(find_possible_two_ways(board, piece) & [create_two(board)])[0]
	end

			private

	def count(possible_two_ways)

 			possible_two_ways.flatten.map {|spot| 
				if possible_two_ways.count(spot) > 1
					spot
				end}
			possible_two_ways.uniq.compact
		end

end
# @player = Player.new(true, true)
# @board = Board.new
# 		@board.game_board[8] = "O"
# 		@board.game_board[3] = "O"
# 		@board.game_board[1] = "X"
# 		# @board.display
# p @player.block_two_way_lose(@board, "O")

