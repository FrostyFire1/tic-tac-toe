
require './lib/tic_tac_toe.rb'

describe Game do
  let(:player1) { Player.new("Mark", "O")}
  let(:player2) { Player.new("John", "X")}
  subject(:tic_tac_toe) { described_class.new(player1, player2) }
  describe "#start" do
    #Does nothing on it's own. Test commands inside it.
  end

  describe "#play_turn" do
    #Game loop. Make sure it sends messages

    context "when player makes a valid turn" do
      
      before do
        allow(tic_tac_toe).to receive(:gets).and_return('9','n')
        allow(tic_tac_toe).to receive(:to_row_cell).and_return([2,2])
        allow(tic_tac_toe).to receive(:win?).and_return(true)
      end

      it "sends a message to convert input to a row and a cell" do
        expect(tic_tac_toe).to receive(:to_row_cell)
        tic_tac_toe.send(:play_turn,player1)
      end

      it "sends a message to place player's symbol" do
        expect(tic_tac_toe).to receive(:place_symbol).with(2,2,"O")
        tic_tac_toe.send(:play_turn,player1)
      end

      it "stops execution if player won" do
        expect(tic_tac_toe).to receive(:play_turn).once
        tic_tac_toe.send(:play_turn,player1)
      end

      it "sends message to ask_to_play_again if player won" do
        expect(tic_tac_toe).to receive(:ask_to_play_again)
        tic_tac_toe.send(:play_turn,player1)
      end
    end

    context "when player makes an invalid turn once" do
      before do
        invalid_input = 'a'
        valid_input = '9'
        allow(tic_tac_toe).to receive(:gets).and_return(invalid_input,valid_input)
        allow(tic_tac_toe).to receive(:to_row_cell).and_return([2,2])
        allow(tic_tac_toe).to receive(:win?).and_return(true)
        allow(tic_tac_toe).to receive(:ask_to_play_again).and_return(nil)
        allow(tic_tac_toe).to receive(:print_board).and_return(nil)
      end
      it "displays error message once" do
        error_message = "You can't place your symbol there! Try again."
        ask_msg = "Where do you want to play?"
        expect(tic_tac_toe).to receive(:puts).with(ask_msg).twice
        expect(tic_tac_toe).to receive(:puts).with(error_message).once
        tic_tac_toe.send(:play_turn, player1)
      end
    end

    context "when player makes an invalid turn five times" do
      before do
        invalid_input = 'a'
        invalid_number = '123123'
        valid_input = '9'
        allow(tic_tac_toe).to receive(:gets).and_return(invalid_input,invalid_number,invalid_input,invalid_number,invalid_input,valid_input)
        allow(tic_tac_toe).to receive(:to_row_cell).and_return([2,2])
        allow(tic_tac_toe).to receive(:win?).and_return(true)
        allow(tic_tac_toe).to receive(:ask_to_play_again).and_return(nil)
        allow(tic_tac_toe).to receive(:print_board).and_return(nil)
      end
      it "displays error message five times" do
        error_message = "You can't place your symbol there! Try again."
        ask_msg = "Where do you want to play?"
        expect(tic_tac_toe).to receive(:puts).with(ask_msg).exactly(6).times
        expect(tic_tac_toe).to receive(:puts).with(error_message).exactly(5).times
        tic_tac_toe.send(:play_turn, player1)
      end
    end

  end

  describe "#print_board" do
    #Print function. Doesn't need testing.
  end
end