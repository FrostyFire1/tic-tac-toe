class Player
  attr_accessor(:wins, :losses)
  attr_reader(:symbol)

  def initialize(name, symbol)
    @name = name
    @wins = 0
    @losses = 0
    @symbol = symbol
  end
end

class Game
  attr_accessor(:player1, :player2)

  def initialize (player1, player2)
    if player1.symbol == player2.symbol
      raise ArgumentError, "Players can't have the same symbol!"
    end

    @board = Array.new(3) { Array.new(3) }
    @player1 = player1
    @player2 = player2
  end

  private
  
  def print_board
    0.upto(@board.length-2) do |row|
     0.upto(@board[row].length-2) do |i|
      print "#{@board[row][i]} | "
     end
     puts
     puts '--' * @board.length
    end
    0.upto(@board[-1].length-2) do |i| # Print the last row
      print "#{@board[-1][i]} | "
     end
  end
end