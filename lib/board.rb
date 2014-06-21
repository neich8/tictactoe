class Board
	attr_accessor :game_board, :middle
	def initialize
		@game_board = (1..9).to_a
		@middle = game_board[mid]
	end

	def middle=(piece)
		game_board[mid] = piece
	end

	def middle
		game_board[mid]
	end

	def open_corner
		@game_board.map{|space| space if space % 2 != 0}[0]
	end

	def row_search
		rows_count = 0
		posible_spots = []
		while rows_count < 3
			if	row(rows_count).include?("O") #and doesnt include "X"
				posible_spots << row(rows_count)
			end
			rows_count += 1
		end
		posible_spots.flatten
	end

	def column_search
		columns_count = 0
		posible_spots = []
		while columns_count < @game_board.length / 3
			if column(columns_count).include?("O")
				posible_spots << column(columns_count)
			end
			columns_count += 1
		end
		posible_spots.flatten
	end

	def diagonal_search
			if diagonal.include?("O")
				diagonal.flatten.uniq
			end
	end

	def row(row_number)
		@game_board.select.with_index { |number, index|  (index) / 3 == row_number}
	end

	def column(col_number)
		iterate_unusually(col_number, 3)
	end
#start must be either 0 or 2
	def diagonal
		diag_down_right + diag_down_left
	end

def two_in_a_row(row_num)
	counter = 0
	array = row(row_num)
	array.each do |spot| 
		if spot == "O"
			counter += 1
		end
	end

	if counter == 2
		array << "ALERT"
	end
	array
end

	def display
	 @game_board.each_slice(3).to_a.each {|row|
	 	p row}
	end

	private 

	def diag_down_left
		i = 2
		diags = []
		while i <= 6
			diags << @game_board[i]
			i += 2
		end
		diags
	end


	def diag_down_right
				diagonals = []
		@game_board.each_with_index do |spot, index|
			if index % 4 == 0 
				diagonals << spot
			end
		end
		diagonals
	end

	def mid
		(@game_board.length - 1) / 2
	end

	def iterate_unusually(start,direction)
		answer = []
		while answer.length < direction
			answer << @game_board[start] 
			start += direction
		end
		answer
	end

end

board = Board.new
board.display
# board.game_board[0] = "O"
# board.game_board[1] = "O"
# puts board.two_in_a_row(0)