require "byebug"

module Computer
	def find_moves(board)
		best_possible_move(board, board.flatten!.select{|spot| spot.is_a? Integer}, "X")
	end

	def best_possible_move(board, possible_moves,piece ,scores={})
		possible_moves.each do |move|
			board[move-1] = piece
			if game.over?
				scores[move] += game.score || scores[move] = game.score
			else
				best_possible_move(board, possible_moves, find_piece(piece), scores)
			end
		end
		scores
	end

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
				# unless row.include? Computer.find_piece(piece)
					# puts "row includes my piece only"
					# p row
					return row.select{|spot| spot.is_a? Integer}
				# end
			end
		end
	end

	def self.column_includes?(board, piece)
		board.find_columns.each do |column|
			if column.include? piece
				# unless column.include? Computer.find_piece(piece)
					# puts "column includes my piece only"
					# p column
					return column.select{|spot| spot.is_a? Integer}
				# end
			end
		end
	end

	def self.diagonal_includes?(board, piece)
		board.find_diagonals.each do |diagonal|
			if diagonal.include? piece
				# unless diagonal.include? Computer.find_piece(piece)
				# 		# puts "diagonal includes my piece only"
				# 		# p column
					return diagonal.select{|spot| spot.is_a? Integer}
				# end
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
