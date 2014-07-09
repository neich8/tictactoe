class Board
  attr_reader  :corners, :diagonals, :game_board, :rows, :columns
  def initialize
    @corners = []
  end

  def game_board
    @game_board ||= (1..9).to_a
  end

  def middle
    game_board[(game_board.length) / 2]
  end

  def find_corners
    corner_seperation = side_length - 1
    corners[0] = game_board.first
    corners[1] = game_board[0 + corner_seperation]
    corners[2] = game_board[(game_board.length - 1) - corner_seperation]
    corners[3] = game_board.last
  end

  def find_rows
    @rows = game_board.each_slice(side_length).to_a
  end

  def find_columns
    @columns = find_rows.transpose
  end

  def find_diagonals
    @diagonals = [ diag_down_left, diag_down_right ]
  end

  def display
    game_board.each_slice(3).to_a.each {|row| p row}
  end

  private

  def diag_down_right
    find_rows.map.with_index do |row, i|
      row[side_length - 1 - i]
    end
  end

  def diag_down_left
    find_rows.map.with_index do |row, i|
      row[i]
    end
  end

  def side_length
    @side_length ||= Math.sqrt game_board.length
  end
end
