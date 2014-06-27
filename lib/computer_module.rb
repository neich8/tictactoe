require "byebug"

module Computer

	def self.two_in_a_row(board, piece)
		two_rows = []
		board.find_rows.each do |row|
			if row.count(piece) == 2 
				unless row.include?(find_piece(piece))
					two_rows << row.select{|spot| spot.is_a? Integer}
				end
			end
		end
		two_rows.flatten
	end

	def self.two_in_a_column(board, piece)
		two_columns = []
		board.find_columns.each do |column|
			if column.count(piece) == 2
				unless column.include?(find_piece(piece))
					two_columns << column.select{|spot| spot.is_a? Integer}
				end
			end
		end
		two_columns.flatten
	end

	def self.two_in_a_diagonal(board, piece)
		two_diagonals = []
		board.find_diagonals.each do |diagonal|
			if diagonal.count(piece) == 2
				unless diagonal.include?(find_piece(piece))
					two_diagonals << diagonal.select{|spot| spot.is_a? Integer}
				end
			end
		end
		two_diagonals.flatten
	end

	def self.row_includes?(board, piece)
		board.find_rows.each do |row|
			if row.include? piece
				return row.select{|spot| spot.is_a? Integer}
			end
		end
	end

	def self.column_includes?(board, piece)
		board.find_columns.each do |column|
			if column.include? piece

				column.select{|spot| spot.is_a? Integer}
			end
		end
	end

	def self.diagonal_includes?(board, piece)
		board.find_diagonals.each do |diagonal|
			if diagonal.include? piece
				return diagonal.select{|spot| spot.is_a? Integer}
			end
		end
	end

	def self.two_way_loses(board,piece)

	end

	def self.find_piece(piece)
		if piece == "X"
			"O"
		else
			"X"
		end
	end
end
