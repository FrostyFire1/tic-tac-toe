class Player
  attr_accessor(:wins, :losses, :next)
  attr_reader(:symbol, :name)

  def initialize(name, symbol)
    @name = name
    @wins = 0
    @losses = 0
    @symbol = symbol
    @next = nil
  end
end

class Game
  attr_accessor(:player1, :player2)

  def initialize(player1, player2)
    raise ArgumentError, "Players can't have the same symbol!" if player1.symbol == player2.symbol

    @board = Array.new(3) { Array.new(3) }
    @player1 = player1
    @player2 = player2
    @player1.next = @player2
    @player2.next = @player1
  end

  def start
    play_turn(player1)
  end

  def debug
    print_board
  end

  private

  def win?(player)
    if [win_row?(player), win_column?(player), win_diagonal?(player)].any?
      print_board
      player.wins += 1
      player.next.losses += 1
      puts "#{player.name} wins! Score: #{player.wins} - #{player.losses}"
      true
    else
      false
    end
  end

  def win_row?(player)
    @board.any? { |row| row.all? { |cell| cell == player.symbol } }
  end

  def win_column?(player)
    0.upto(@board.length-1) do |column_index|
      symbols = []
      @board.each do |row|
        symbols << row[column_index]
      end

      if symbols.uniq.length == 1 && symbols[0] == player.symbol 
        # Checks if column has 1 symbol across it
        return true
      end
    end
    false
  end

  def win_diagonal?(player)
    board_size = @board.length-1

    symbols_down = []
    0.upto(board_size) do |diagonal_down|
      symbols_down << @board[diagonal_down][diagonal_down]
    end

    symbols_up = []
    0.upto(board_size) do |diagonal_up|
      symbols_up << @board[board_size-diagonal_up][diagonal_up]
    end

    (symbols_down.uniq.length == 1 &&
    symbols_down[0] == player.symbol) ||
      (symbols_up.uniq.length == 1 &&
      symbols_up[0] == player.symbol)
  end

  def print_board
    0.upto(@board.length - 2) do |row|
      to_print = []
      0.upto(@board[row].length - 1) do |i|
        to_print << if @board[row][i].nil?
                      row * @board[row].length + (i + 1)
                    else
                      @board[row][i]
                    end
      end
      puts to_print.join('|')
      puts '--' * @board.length
    end
    last_print = []
    0.upto(@board[-1].length - 1) do |i| # Print the last row
      if @board[-1][i].nil?
        last_print << (@board[-1].length - 1) * @board.length + (i + 1)
      else
        last_print << @board[-1][i]
      end
    end
    puts last_print.join('|')
  end

  def to_row_cell(place_index)
    row = (place_index / @board.length.to_f).ceil - 1
    cell = (place_index - row * @board.length) - 1
    [row,cell]
  end

  def place_symbol(row,cell, symbol)
    @board[row][cell] = symbol
  end

  def play_turn(player)
    print_board
    puts "Where do you want to play?"
    to_place = gets.chomp.to_i
    row, cell = to_row_cell(to_place)
    if to_place.between?(1, @board.length**2)
       @board[row][cell].nil?

      place_symbol(row,cell, player.symbol)
      to_play = player.next
      if !win?(player)
        play_turn(to_play)
      else
        ask_to_play_again
      end
    else
      puts "You can't place your symbol there! Try again."
      play_turn(player)
    end
  end

  def ask_to_play_again
    puts 'Would you like to play again? Y/y for yes, anything else for no'
    return unless gets.chomp.downcase == 'y'

    @board = Array.new(3) { Array.new(3) }
    start
  end
end

print "Player #1's name: "
p1_name = gets.chomp
print "Player #2's name: "
p2_name = gets.chomp
player1 = Player.new(p1_name, 'O')
player2 = Player.new(p2_name, 'X')
game = Game.new(player1, player2)

game.start
