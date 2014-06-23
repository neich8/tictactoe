class Board
attr_reader  :side_length, :corners, :diagonals, :game_board, :rows, :columns
	def initialize
		@game_board = (1..9).to_a
		@corners = []
		find_side_length
	end

	def middle
		@game_board[(@game_board.length) / 2]
	end

	def find_corners

		corner_seperation = @side_length - 1
		corners[0] = @game_board.first
		corners[1] = @game_board[0 + corner_seperation]
		corners[2] = @game_board[(@game_board.length - 1) - corner_seperation]
		corners[3] = @game_board.last
	end

	def find_rows
		@rows = @game_board.each_slice(@side_length).to_a
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
		@game_board.each_slice(3).to_a.each {|row|
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
		area = @game_board.length
		guess = @game_board.length 
		while guess > 0
			if guess * guess == area
				@side_length = guess
				break
			end
			guess -= 1
		end
	end
end



board = Board.new


board.find_rows



































# 	attr_accessor :game_board, :middle
# 	def initialize
# 		@game_board = (1..9).to_a
# 		@middle = game_board[mid]
# 	end

# 	def middle=(piece)
# 		game_board[mid] = piece
# 	end

# 	def middle
# 		game_board[mid]
# 	end

# 	def open_corner
# 		p @game_board.map{|space| 
# 			if space % 2 != 0 && space.class == Fixnum
# 				space
# 			end
# 			}.compact
# 	end

# 	def row_search
# 		rows_count = 0
# 		posible_spots = []
# 		while rows_count < 3
# 			if	pull_row(rows_count).include?("O") #and doesnt include "X"
# 				find_two_in_a_row(rows_count)
# 				posible_spots << pull_row(rows_count)
# 			end
# 			rows_count += 1
# 		end
# 		posible_spots.flatten
# 	end

# 	def column_search
# 		columns_count = 0
# 		posible_spots = []
# 		while columns_count < @game_board.length / 3
# 			if pull_column(columns_count).include?("O")
# 				find_two_in_a_row(columns_count)
# 				posible_spots << pull_column(columns_count)
# 			end
# 			columns_count += 1
# 		end
# 		posible_spots.flatten
# 	end

# 	def diagonal_search
# 		if diagonal.include?("O")
# 			find_two_in_a_row
# 			diagonal.flatten.uniq
# 		end
# 	end

# 	def pull_row(row_number)
# 		@game_board.select.with_index { |number, index|  (index) / 3 == row_number}
# 	end

# 	def pull_column(col_number)
# 		answer = []
# 		while answer.length < 3
# 			answer << @game_board[col_number] 
# 			col_number += 3
# 		end
# 		answer
# 	end
# #start must be either 0 or 2
# 	def diagonal
# 		diag_down_right + diag_down_left
# 	end

# 	def two_in_a_row(row_num)
# 		counter = 0
# 		array = pull_row(row_num)
# 		array.each do |spot| 
# 			if spot == "O"
# 				counter += 1
# 			end
# 		end
# 		if counter == 2
# 			array << "ALERT"
# 		end
# 		array
# 	end

# 	def display
# 		@game_board.each_slice(3).to_a.each {|row|
# 	 	p row}
# 	end

# 	private 

# 	def pull_diag_down_left
# 		i = 2
# 		diags = []
# 		while i <= 6
# 			diags << @game_board[i]
# 			i += 2
# 		end
# 		diags
# 	end


# 	def pull_diag_down_right
# 		diagonals = []
# 		@game_board.each_with_index do |spot, index|
# 			if index % 4 == 0 
# 				diagonals << spot
# 			end
# 		end
# 		diagonals
# 	end

# 	def mid
# 		(@game_board.length - 1) / 2
# 	end
