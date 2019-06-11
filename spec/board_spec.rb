# frozen_string_literal: true

require './lib/board.rb'

describe Board do
  out_of_range_num = 2
  board_num = 9
  let(:player_piece) { %w[O X].sample }
  let(:out_of_range) { [0, 10] }
  let(:occupied) { rand(1..board_num) }
  let(:unoccupied) { (1..board_num).reject { |pos| pos == occupied }.sample }
  let(:occupy_full) { @board.test_occupy_num(board_num) }
  let(:occupy_once) { @board.state[occupied - 1] = player_piece }
  let(:fill_in_at_place) { @board.update_state(player_piece, occupied) }
  let(:occupy_once_num) { 1 }
  before { @board = Board.new }

  describe '#in_range?' do
    1.upto(board_num) do |e|
      it "returns true if grid number is valid; false otherwise - piece #{e}" do
        expect(@board.in_range?(e)).to eql(true)
      end
    end

    0.upto(1) do |e|
      it "returns true if grid number is valid; false otherwise - out range case, #{e + 1}" do
        expect(@board.in_range?(out_of_range[e])).to eql(false)
      end
    end
  end

  describe '#update_state' do
    it 'returns increased occupy number' do
      expect(fill_in_at_place).to eql(occupy_once_num)
    end

    it 'changes board state' do
      fill_in_at_place
      expect(@board.state[occupied - 1]).to eql(player_piece)
    end
  end

  describe '#occupied?' do
    context 'when occupied place' do
      it 'returns true if position is occupied; false otherwise' do
        occupy_once
        expect(@board.occupied?(occupied)).to eql(true)
      end
    end

    context 'when unoccupied place' do
      it 'returns true if position is occupied; false otherwise' do
        occupy_once
        expect(@board.occupied?(unoccupied)).to eql(false)
      end
    end
  end

  describe '#full?' do
    it 'return full after 9 moves' do
      occupy_full
      expect(@board.full?).to eql(true)
    end
  end
end
