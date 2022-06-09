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
end