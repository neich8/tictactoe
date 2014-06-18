class Board
	attr_accessor :game_board
	def initialize
		@game_board = (1..9).to_a
	end

end
