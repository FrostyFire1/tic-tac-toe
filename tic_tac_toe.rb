class Player
  attr_accessor(:wins, :losses, :next)
  attr_reader(:symbol)

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

  def initialize (player1, player2)
    if player1.symbol == player2.symbol
      raise ArgumentError, "Players can't have the same symbol!"
    end

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

  def play_turn(player)
    print_board
    to_place = gets('Where do you want to play?').chomp.to_i
    place_symbol(to_place, player.symbol)
    to_play = player.next
    play_turn(to_play) unless win?()
  end
end

player1 = Player.new("John", "O")
player2 = Player.new("Marc", "X")
game = Game.new(player1, player2)

game.debug