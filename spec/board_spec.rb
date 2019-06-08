require "./lib/board.rb"

describe Board do
  before (:each) { @board = Board.new }
  let(:player_piece) { ["O", "X"].sample }
  let(:out_of_range) { rand(2) + 10 }
  let(:occupied) { rand(8) + 1 }
  let(:unoccupied) { (1..9).reject{ |pos| pos == occupied}.sample }
 
  describe "#in_range?" do
    it "returns true if grid number is valid; false otherwise" do
      expect(@board.in_range?(occupied)).to eql(true)
      expect(@board.in_range?(out_of_range)).to eql(false)
    end
  end

  describe "#update_state?" do
    it "updates state" do
      @board.update_state(player_piece, occupied)
      expect(@board.state[occupied - 1]).to eql(player_piece)
    end
  end

  describe "#occupied?" do
    it "returns true if position is occupied; false otherwise" do
      @board.update_state(player_piece, occupied)
      expect(@board.occupied?(occupied)).to eql(true)
      expect(@board.occupied?(unoccupied)).to eql(false)
    end
  end

  describe "#full?" do
    it "return full after 9 moves" do
      1.upto(9) { |position| @board.update_state(player_piece, position) }
      expect(@board.full?).to eql(true)
    end
  end

end