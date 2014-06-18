require_relative "./pieces"

class Player
	attr_accessor :active
	attr_reader :piece

	def pick_piece
		if active == true && piece == nil
			@piece = Piece.new("X")
		else
			@piece = Piece.new("O")
		end
	end

	def auto_move(board)
		if player = 

	end

	private
#AI moving Algo

end

