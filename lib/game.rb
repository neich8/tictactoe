require_relative "./player"
require_relative "./board"
# require "byebug"
#Comment out lines 18 and 94 befor running tests
class Game
  attr_accessor :players
  attr_reader :player1, :player2, :board

  def initialize
    @board = Board.new
    add_players
  end

  def add_players
    is_x = pick_first_player == 1
    activate_players(is_x, !is_x)
  end

  def turn
    puts "'s turn"
    @board.display

    if @player1.active
      puts "Type a number to pick a spot"
      move(@player1, gets.to_i)
    else
      move(@player2, @player2.ai_move(@board))
      puts "Computers turn"
    end
  end

  def move(player, spot)
    return unless player.active

    if spot.is_a? Integer
      @board.game_board[spot - 1] = player.piece.type

      end_game if over?(player)
    end

    next_player
  end

  def over?(player)
    sort_board
    three_in_a_(board.rows, player) || \
      three_in_a_(board.columns, player)|| \
      three_in_a_(board.diagonals, player) || \
      no_moves
  end

  def sort_board
    @board.find_rows
    @board.find_columns
    @board.find_diagonals
  end

  def end_game
    puts "Game OVer"
    @board.display
    exit
  end


  def three_in_a_(area, player)
    area.select! { |row| row == Array.new(3, player.piece.type) }
    area.length > 0
  end

  private
  def next_player
    puts "Next Player is being set"
    sleep 1 unless ENV["RUBY_ENV"] == "test"

    @player2.active = @player1.active   # Set p2 to p1's status
    @player1.active = ! @player1.active # Toggle p1

    puts "Player #{@player1.active ? 1 : 2}'s turn"
  end

  def activate_players(player1_status, player2_status)
    @player1 = Player.new(player1_status, true)
    @player2 = Player.new(player2_status, false)
  end

  def pick_first_player
    rand(2)
  end

  def no_moves
    @board.game_board.select {|spot| spot.is_a? Integer}.length.zero?
  end

end

Game.new if __FILE__ == $!
