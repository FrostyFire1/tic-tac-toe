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
      puts "#{player.name} wins!"
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

      return true if symbols.uniq.length == 1 # Checks if column has 1 symbol across it
    end
    false
  end

  def win_diagonal?(player)
    board_size = @board.length

    symbols_down = []
    0.upto(board_size-1) do |diagonal_down|
      symbols_down << @board[diagonal_down][diagonal_down]
    end

    symbols_up = []
    0.upto(board_size-1) do |diagonal_up|
      symbols_up << @board[diagonal_up][board_size-diagonal_up]
    end

    symbols_down.uniq.length == 1 || symbols_up.uniq.length == 1
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

  def place_symbol(place_index, symbol)
    row = (place_index / @board.length.to_f).ceil - 1
    cell = (place_index - row * @board.length) - 1
    puts row,cell
    @board[row][cell] = symbol
  end

  def play_turn(player)
    print_board
    puts "Where do you want to play?"
    to_place = gets.chomp.to_i
    place_symbol(to_place, player.symbol)
    to_play = player.next
    play_turn(to_play) unless win?(player)
  end
end

player1 = Player.new('John', 'O')
player2 = Player.new('Marc', 'X')
game = Game.new(player1, player2)

game.start
