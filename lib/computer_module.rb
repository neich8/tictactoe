module Computer

	def self.two_in_a_row(board, piece)
		board.find_rows.each do |row|
			if row.count(piece) == 2
				return row.select{|spot| spot.is_a? Integer}[0]
			end
		end
	end

	def self.two_in_a_column(board, piece)
		board.find_columns.each do |column|
			if column.count(piece) == 2
				return column.select{|spot| spot.is_a? Integer}[0]
			end
		end
	end

	def self.two_in_a_diagonal(board, piece)
		board.find_diagonals.each do |diagonal|
			if diagonal.count(piece) == 2
				return diagonal.select{|spot| spot.is_a? Integer}[0]
			end
		end
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
				return column.select{|spot| spot.is_a? Integer}
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
end
