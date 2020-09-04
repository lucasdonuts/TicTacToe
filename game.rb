require_relative 'player'
require_relative 'board'
class TicTacToe
  attr_reader :current_player
  attr_reader :player_1
  attr_reader :player_2
  def initialize
#     get player 1 name
    puts "Who is player 1?"
    first = gets.chomp
#     create player instance
    @player_1 = Player.new(first)
#     get player 2 name
    puts "Who is player 2?"
    second = gets.chomp
#     create player instance
    @player_2 = Player.new(second)
#     current player is player 1
    @current_player = @player_1
#     create board instance
    @board = Board.new

    play_round(@current_player)
#   end?
  end

  def get_choice(current_player)
    puts "#{current_player.name}, pick a cell, 1-9."
    choice = gets.chomp.to_i
  end

  def take_turn (current_player, choice)
    current_player == @player_1 ? symbol = "X" : symbol = "O"
    @board.place_symbol(current_player, symbol, choice)
  end

  def play_round(current_player)
    @board.display
    choice = get_choice(current_player)
    if !take_turn(current_player, choice)
      play_round(current_player)
    else
      if(@board.check_game_over == "Win")
        puts "------------------------"
        puts "------------------------"
        puts "#{current_player.name}, You win!"
        puts "------------------------"
        puts "------------------------"
        @board.display
        if play_again?
          restart_game
        else
          exit
        end
      elsif(@board.check_game_over == "Draw")
        puts "It's a draw"
        @board.display
        if play_again?
          restart_game
        else
          exit
        end
      else
        switch_current_player(current_player)
        play_round(@current_player)
      end
    end
  end

  def play_again?
    puts "Play again? (y/n): "
    answer = gets.chomp
    if (answer == "y")
      true
    elsif (answer == "n")
      false
    else
      puts "Invalid answer"
      play_again?
    end
  end

  def restart_game
    initialize
  end
  
  def switch_current_player(current_player)
    current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
  end

end

game = TicTacToe.new