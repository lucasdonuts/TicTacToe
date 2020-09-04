require_relative 'player'
# create board class
class Board
  # initialize with empty 3x3 array
  def initialize
    @board = Array.new(3) { Array.new(3) }
    @coords = {
      1 => [0, 0],
      2 => [0, 1],
      3 => [0, 2],
      4 => [1, 0],
      5 => [1, 1],
      6 => [1, 2],
      7 => [2, 0],
      8 => [2, 1],
      9 => [2, 2]
    }
  end

  def display
    @board.each do |row|
      row.each do |cell|
        print cell.nil? ? "- " : "#{cell} "
      end
      puts
    end
    puts
  end

  def place_symbol(player, symbol, choice)
    if move_valid?(choice)
      if cell_empty?(choice)
        @board[@coords[choice][0]][@coords[choice][1]] = symbol
        puts "Valid move."
        check_game_over
        return true
      else
        puts "That spot is taken. Try again."
        return false
      end
    else
      puts "Coordinates invalid. Try again."
      return false
    end
  end

  def move_valid?(choice)
    (1..9).include?(choice) ? true : false
  end

  def cell_empty?(choice)
    @board[@coords[choice][0]][@coords[choice][1]].nil?
  end

  def check_game_over
    if winning_combination?
      return "Win"
    elsif board_full?
      return "Draw"
    else
      false
    end
  end

  def winning_combination?
    vertical? ||
    horizontal? ||
    diagonal?
  end

  def board_full?
    @board.each do |row|
      row.each do |cell|
        return false if cell.nil?
      end
    end
  end

  def vertical?
    verticals = {
      1 => [@board[0][0], @board[1][0], @board[2][0]],
      2 => [@board[0][1], @board[1][1], @board[2][1]],
      3 => [@board[0][2], @board[1][2], @board[2][2]]
    }

    match = false

    verticals.each do |k, v|
      match = true if (verticals[k].uniq.count <= 1 && verticals[k].none? { |cell| cell.nil? })
    end
    match
  end

  def horizontal?
    horizontals = {
      1 => [@board[0][0], @board[0][1], @board[0][2]],
      2 => [@board[1][0], @board[1][1], @board[1][2]],
      3 => [@board[2][0], @board[2][1], @board[2][2]]
    }

    match = false

    horizontals.each do |k, v|
      match = true if (horizontals[k].uniq.count <= 1 && horizontals[k].none? { |cell| cell.nil? })
    end
    match
  end

  def diagonal?
    diagonals = {
      1 => [@board[0][0], @board[1][1], @board[2][2]],
      2 => [@board[2][0], @board[1][1], @board[0][2]]
    }

    match = false
    
    diagonals.each do |k, v|
      match = true if (diagonals[k].uniq.count <= 1 && diagonals[k].none? { |cell| cell.nil? })
    end
    match
  end

end

board = Board.new