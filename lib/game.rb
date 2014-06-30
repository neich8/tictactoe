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
		if pick_first_player == 1
			activate_players(true, false)
		else
			activate_players(false,true)
		end
		 # turn
	end

	def turn
		find_player
		puts "'s turn"
		@board.display

		if @player1.active == true
			puts "Type a number to pick a spot"
			move(@player1, gets.chomp.to_i)
		else
			move(@player2, @player2.ai_move(@board))
			puts "Computers turn"
		end

	end

	def move(player, spot)
		if player.active
			if spot.is_a? Integer
				@board.game_board[spot - 1] = player.piece.type
				if over?(player)
					end_game
				end
			else
				# turn
			end
		next_player
		end
	end

	def over?(player)
		sort_board

		if three_in_a_(board.rows, player) || three_in_a_(board.columns, player)|| three_in_a_(board.diagonals, player) || no_moves

			true
		end
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

	private

	def three_in_a_(area, player)

		area.select! { |row| row == Array.new(3, player.piece.type) }
			if area.length > 0
				true
			else
				false
			end
	end
	def next_player
		puts "Next Player is being set"
		sleep 1
		if @player1.active

			@player1.active = false
			@player2.active = true
						puts "player ones turn"
			puts @player1.active
		else

			@player1.active = true
			@player2.active = false
						puts "player twos turn"
			puts @player2.active
		end
		 # turn
	end

	def find_player
		if @player1.active == true
			@players = {human: @player1, computer: @player2}
		else
			@players = {computer: @player2, human: @player1}
		end
	end


	def activate_players(player1_status, player2_status)
		@player1 = Player.new(player1_status, true)
		@player2 = Player.new(player2_status, false)
	end

	def pick_first_player
		rand(2)
	end

	def no_moves
		# unless @board.game_board.select {|spot| spot.is_a? Integer} > 0
		# 	true
		# end
	end
end

game = Game.new