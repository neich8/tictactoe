require "byebug"

module Computer

  def self.two_in_a_(method, board, piece)
		res = []
		board.send(method).each do |set|
			if set.count(piece) == 2 
				unless set.include?(find_piece(piece))
					res << set.select{|spot| spot.is_a? Integer}
				end
			end
		end
		res.flatten
  end

	def self.two_in_a_row(board, piece)
    two_in_a_(:find_rows, board, piece)
	end

	def self.two_in_a_column(board, piece)
    two_in_a_(:find_columns, board, piece)
	end

	def self.two_in_a_diagonal(board, piece)
    two_in_a_(:find_diagonals, board, piece)
	end

  def self.something_includes?(method, board, piece)
    board.send(method).each do |set|
      if set.include? piece
        return set.select{|spot| spot.is_a? Integer}
      end
    end
  end

	def self.row_includes?(board, piece)
    something_includes?(:find_rows, board, piece)
	end

	def self.column_includes?(board, piece)
    something_includes?(:find_columns, board, piece)
	end

	def self.diagonal_includes?(board, piece)
    something_includes?(:find_diagonals, board, piece)
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
