# frozen_string_literal: true

require './lib/player.rb'
require './lib/board.rb'
require './lib/game.rb'

RSpec.describe Game do
  let(:player) do
    [
      double(name: 'ABC', stone: :O),
      double(name: 'DEF', stone: :X)
    ]
  end
  let(:winner_idx) { rand(2) }
  let(:no_winer_idx) { (0..1).reject { |idx| idx == winner_idx }.sample }
  let(:p) { player[winner_idx].stone }
  let(:q) { player[no_winer_idx].stone }
  let(:win_board) do
    [
      double(state: [p, p, p, 4, 5, 6, 7, 8, 9]), # row_top
      double(state: [1, 2, 3, p, p, p, 7, 8, 9]), # row_mid
      double(state: [1, 2, 3, 4, 5, 6, p, p, p]), # row_bottom
      double(state: [p, 2, 3, p, 5, 6, p, 8, 9]), # col_left
      double(state: [1, p, 3, 4, p, 6, 7, p, 9]), # col_mid
      double(state: [1, 2, p, 4, 5, p, 7, 8, p]), # col_right
      double(state: [p, 2, 3, 4, p, 6, 7, 8, p]), # diag_r_low
      double(state: [1, 2, p, 4, p, 6, p, 8, 9]) # diag_r_higher
    ]
  end

  let(:no_winer_board) do
    [
      double(state: [1, 2, 3, 4, 5, 6, 7, 8, 9]), # default
      double(state: [p, 2, 3, 4, 5, 6, 7, 8, 9]), # only1
      double(state: [p, p, 3, 4, 5, 6, 7, 8, 9]), # only2
      double(state: [p, q, p, 4, 5, 6, 7, p, 9]), # rand_1
      double(state: [1, p, 3, 4, 5, 6, p, q, p]), # rand_2
      double(state: [p, 2, 3, q, 5, p, p, 8, 9]), # rand_3
      double(state: [1, 2, p, p, 5, q, 7, 8, q]) # rand_4
    ]
  end

  let(:rand_win) { rand(win_board.length) }
  let(:win_game) { Game.new(player[0], player[1], win_board[rand_win]) }
  let(:winner_name) { player[winner_idx].name }
  let(:rand_no_winer) { rand(no_winer_board.length) }
  let(:no_winer_game) { Game.new(player[0], player[1], no_winer_board[rand_no_winer]) }
  let(:no_winer_name) { player[no_winer_idx].name }

  before do
    win_game.test_winner_status_update(player[winner_idx])
    no_winer_game.test_winner_status_update(player[no_winer_idx])
  end

  describe '@winner after #test_winner_status_update' do
    context 'when no winner' do
      it 'contains no object' do
        expect(no_winer_game.winner).to_not eql(player[winner_idx])
      end
    end

    context 'when winner' do
      it 'contains winner object' do
        expect(win_game.winner).to eql(player[winner_idx])
      end
    end
  end # describe '@winner' do
end
