
require '../lib/tic_tac_toe.rb'

describe Game do
  let(:player1) { Player.new("Mark", "O")}
  let(:player2) { Player.new("John", "X")}
  subject(:tic_tac_toe) { described_class.new()}
  describe "#start" do
    #Does nothing on it's own. Test commands inside it.
  end

  describe "#play_turn" do

  end
end