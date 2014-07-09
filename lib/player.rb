require_relative "./pieces"
require_relative "./board"
require_relative "./computer"
require "byebug"
class Player 
  attr_accessor :active, :human
  attr_reader :piece, :board, :opposing_piece

  def initialize(active, human_status)
    @active = active
    pick_piece
    @human = human_status
  end

  def pick_piece
    if @active && @piece.nil?
      @piece = Piece.new("X")
      @opposing_piece = "O"
    else
      @piece = Piece.new("O")
      @opposing_piece = "X"
    end
  end

  def ai_move(board)
    if end_game(board).available?
      return end_game(board)
    end

    if middle(board).available?
      return middle(board)
    end

    if block_two_way_lose(board).available?
      return block_two_way_lose(board)
    end

    if block_two_in_a_row(board)[0].available?
      return block_two_in_a_row(board)[0]
    end 

    if block(board).available?
      return block(board)
    end 

    if create_two(board).available?
      return create_two(board)
    end
  end

  def block_two_in_a_row(board, piece= @opposing_piece)
    blocks = []
    blocks << Computer.two_in_a_row(board, piece)
    blocks << Computer.two_in_a_column(board, piece)
    blocks << Computer.two_in_a_diagonal(board, piece)
    blocks.flatten
  end

  def block(board)
    compare_moves_corners(board)
  end

  def create_two(board)
    if find_moves(board, piece.type).length != 0 
      find_moves(board, piece.type).max_by{|num| num.size}
    end
  end

  def middle(board)
    if board.game_board[4].available?
      board.game_board[4]
    end
  end

  def find_moves(board, piece=@opposing_piece)
    moves = []
    moves << Computer.row_includes?(board, piece)
    moves << Computer.column_includes?(board, piece)
    moves << Computer.diagonal_includes?(board, piece)
    moves.flatten!
  end

  def compare_moves_corners(board)
    board.find_corners
    find_moves(board).select {|spot| board.corners.include? spot}
  end

  def end_game(board)
    block_two_in_a_row(board, @piece.type)[0]
  end

  def find_possible_two_ways(board, piece= @opposing_piece)
    possible_two_ways = []
    board.game_board.each do |spot|
      next unless spot.available?

      board.game_board[spot - 1] = piece

      next if block_two_in_a_row(board, piece).length.zero?

      possible_two_ways << block_two_in_a_row(board, piece)

      board.game_board[spot - 1] = spot
    end

    possible_two_ways.flatten!
  end

  def block_two_way_lose(board, piece = @opposing_piece)
    (find_possible_two_ways(board, piece) & [create_two(board)])[0]
  end

  private

  def count(possible_two_ways)
    possible_two_ways.flatten.map do |spot| 
      if possible_two_ways.count(spot) > 1
        spot
      end
    end
    possible_two_ways.uniq.compact
  end
end
