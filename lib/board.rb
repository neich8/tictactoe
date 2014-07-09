class Board
attr_reader  :side_length, :corners, :diagonals, :game_board, :rows, :columns
	def initialize
		@corners = []
		find_side_length
	end

  def game_board
		@game_board ||= (1..9).to_a
  end

	def middle
		game_board[(game_board.length) / 2]
	end

	def find_corners
		corner_seperation = @side_length - 1
		corners[0] = game_board.first
		corners[1] = game_board[0 + corner_seperation]
		corners[2] = game_board[(game_board.length - 1) - corner_seperation]
		corners[3] = game_board.last
	end

	def find_rows
		@rows = game_board.each_slice(@side_length).to_a
	end

	def find_columns
		@columns = find_rows.transpose
	end

	def find_diagonals
		@diagonals = []
		@diagonals << diag_down_left
		@diagonals << diag_down_right
	end

	def display
		game_board.each_slice(3).to_a.each {|row|
	 	p row}
	end


	private

	def diag_down_right
		down_left = []
		diagonal_spot = @side_length - 1
		find_rows.each do |row|
			down_left << row[diagonal_spot]
			diagonal_spot -= 1
		end
		down_left
	end

	def diag_down_left
		down_right = []
		diagonal_spot = 0
		find_rows.each do |row|
	 		down_right << row[diagonal_spot]
	 		diagonal_spot += 1
		end
		down_right
	end

	def find_side_length
		area = game_board.length
		guess = game_board.length 
		while guess > 0
			if guess * guess == area
				@side_length = guess
				break
			end
			guess -= 1
		end
	end
end
