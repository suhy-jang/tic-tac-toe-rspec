# frozen_string_literal: true

require './lib/game.rb'

RSpec.describe Game do
  let(:player) do
    [
      double(name: 'EBUKA', stone: :O),
      double(name: 'SUH', stone: :X)
    ]
  end
  let(:mk_winner) { player.sample }
  let(:mk_no_winner) { player.reject { |elem| elem == mk_winner }.sample }
  let(:w) { mk_winner.stone }
  let(:n) { mk_no_winner.stone }
  let(:win_cases) do
    double(t: double(state: [w, w, w, 4, 5, 6, 7, 8, 9]),
           r: double(state: [1, 2, w, 4, 5, w, 7, 8, w]),
           b: double(state: [1, 2, 3, 4, 5, 6, w, w, w]),
           l: double(state: [w, 2, 3, w, 5, 6, w, 8, 9]),
           mv: double(state: [1, w, 3, 4, w, 6, 7, w, 9]),
           mh: double(state: [1, 2, 3, w, w, w, 7, 8, 9]),
           dg_rl: double(state: [w, 2, 3, 4, w, 6, 7, 8, w]),
           dg_rh: double(state: [1, 2, w, 4, w, 6, w, 8, 9]))
  end

  let(:win_game) do
    double(t: Game.new(player.first, player.last, win_cases.t),
           r: Game.new(player.first, player.last, win_cases.r),
           b: Game.new(player.first, player.last, win_cases.b),
           l: Game.new(player.first, player.last, win_cases.l),
           mv: Game.new(player.first, player.last, win_cases.mv),
           mh: Game.new(player.first, player.last, win_cases.mh),
           dg_rl: Game.new(player.first, player.last, win_cases.dg_rl),
           dg_rh: Game.new(player.first, player.last, win_cases.dg_rh))
  end

  let(:no_win_cases) do
    double(mix_t: double(state: [w, n, w, 4, 5, 6, 7, 8, 9]),
           mix_r: double(state: [1, 2, w, 4, 5, n, 7, 8, w]),
           mix_b: double(state: [1, 2, 3, 4, 5, 6, w, n, w]),
           mix_l: double(state: [w, 2, 3, n, 5, 6, w, 8, 9]),
           mix_mv: double(state: [1, n, 3, 4, w, 6, 7, n, 9]),
           mix_mh: double(state: [1, 2, 3, n, w, n, 7, 8, 9]),
           mix_dg_rl: double(state: [n, 2, 3, 4, w, 6, 7, 8, n]),
           mix_dg_rh: double(state: [1, 2, n, 4, w, 6, n, 8, 9]),
           only_one: double(state: [w, 2, 3, 4, 5, 6, 7, 8, 9]),
           only_two: double(state: [w, w, 3, 4, 5, 6, 7, 8, 9]),
           spread_1: double(state: [1, w, w, w, 5, 6, 7, 8, 9]),
           spread_2: double(state: [1, 2, w, w, w, 6, 7, 8, 9]),
           spread_3: double(state: [1, 2, 3, 4, w, w, w, 8, 9]),
           spread_4: double(state: [1, 2, 3, 4, 5, w, w, w, 9]),
           spread_5: double(state: [w, 2, 3, 4, 5, 6, 7, w, w]),
           spread_6: double(state: [w, w, 3, 4, 5, 6, 7, 8, w]),
           default: double(state: [1, 2, 3, 4, 5, 6, 7, 8, 9]))
  end

  let(:no_win_game) do
    double(mix_t: Game.new(player.first, player.last, no_win_cases.mix_t),
           mix_r: Game.new(player.first, player.last, no_win_cases.mix_r),
           mix_b: Game.new(player.first, player.last, no_win_cases.mix_b),
           mix_l: Game.new(player.first, player.last, no_win_cases.mix_l),
           mix_mv: Game.new(player.first, player.last, no_win_cases.mix_mv),
           mix_mh: Game.new(player.first, player.last, no_win_cases.mix_mh),
           mix_dg_rl: Game.new(player.first, player.last, no_win_cases.mix_dg_rl),
           mix_dg_rh: Game.new(player.first, player.last, no_win_cases.mix_dg_rh),
           only_one: Game.new(player.first, player.last, no_win_cases.only_one),
           only_two: Game.new(player.first, player.last, no_win_cases.only_two),
           spread_1: Game.new(player.first, player.last, no_win_cases.spread_1),
           spread_2: Game.new(player.first, player.last, no_win_cases.spread_2),
           spread_3: Game.new(player.first, player.last, no_win_cases.spread_3),
           spread_4: Game.new(player.first, player.last, no_win_cases.spread_4),
           spread_5: Game.new(player.first, player.last, no_win_cases.spread_5),
           spread_6: Game.new(player.first, player.last, no_win_cases.spread_6),
           default: Game.new(player.first, player.last, no_win_cases.default))
  end

  before do
    win_game.t.test_winner_status_update(mk_winner)
    win_game.r.test_winner_status_update(mk_winner)
    win_game.b.test_winner_status_update(mk_winner)
    win_game.l.test_winner_status_update(mk_winner)
    win_game.mv.test_winner_status_update(mk_winner)
    win_game.mh.test_winner_status_update(mk_winner)
    win_game.dg_rl.test_winner_status_update(mk_winner)
    win_game.dg_rh.test_winner_status_update(mk_winner)
    no_win_game.mix_t.test_winner_status_update(mk_no_winner)
    no_win_game.mix_r.test_winner_status_update(mk_no_winner)
    no_win_game.mix_b.test_winner_status_update(mk_no_winner)
    no_win_game.mix_l.test_winner_status_update(mk_no_winner)
    no_win_game.mix_mv.test_winner_status_update(mk_no_winner)
    no_win_game.mix_mh.test_winner_status_update(mk_no_winner)
    no_win_game.mix_dg_rl.test_winner_status_update(mk_no_winner)
    no_win_game.mix_dg_rh.test_winner_status_update(mk_no_winner)
    no_win_game.only_one.test_winner_status_update(mk_no_winner)
    no_win_game.only_two.test_winner_status_update(mk_no_winner)
    no_win_game.spread_1.test_winner_status_update(mk_no_winner)
    no_win_game.spread_2.test_winner_status_update(mk_no_winner)
    no_win_game.spread_3.test_winner_status_update(mk_no_winner)
    no_win_game.spread_4.test_winner_status_update(mk_no_winner)
    no_win_game.spread_5.test_winner_status_update(mk_no_winner)
    no_win_game.spread_6.test_winner_status_update(mk_no_winner)
    no_win_game.default.test_winner_status_update(mk_no_winner)
  end

  describe '@winner' do
    context 'when winner' do
      it 'contains winner object matched for top row in board' do
        expect(win_game.t.winner).to eql(mk_winner)
      end

      it 'contains winner object matched for right column in board' do
        expect(win_game.r.winner).to eql(mk_winner)
      end

      it 'contains winner object matched for bottom row in board' do
        expect(win_game.b.winner).to eql(mk_winner)
      end

      it 'contains winner object matched for left column in board' do
        expect(win_game.l.winner).to eql(mk_winner)
      end

      it 'contains winner object matched for mid column in board' do
        expect(win_game.mv.winner).to eql(mk_winner)
      end

      it 'contains winner object matched for mid row in board' do
        expect(win_game.mh.winner).to eql(mk_winner)
      end

      it 'contains winner object matched for right lower diagonal in board' do
        expect(win_game.dg_rl.winner).to eql(mk_winner)
      end

      it 'contains winner object matched for right higher diagonal in board' do
        expect(win_game.dg_rh.winner).to eql(mk_winner)
      end
    end

    context 'when no winner' do
      it 'contains no object filled with mixed top row in board' do
        expect(no_win_game.mix_t.winner).to eql(nil)
      end

      it 'contains no object filled with mixed right column in board' do
        expect(no_win_game.mix_r.winner).to eql(nil)
      end

      it 'contains no object filled with mixed bottom row in board' do
        expect(no_win_game.mix_b.winner).to eql(nil)
      end

      it 'contains no object filled with mixed left column in board' do
        expect(no_win_game.mix_l.winner).to eql(nil)
      end

      it 'contains no object filled with mixed mid column in board' do
        expect(no_win_game.mix_mv.winner).to eql(nil)
      end

      it 'contains no object filled with mixed mid row in board' do
        expect(no_win_game.mix_mh.winner).to eql(nil)
      end

      it 'contains no object filled with mixed right lower diagonal in board' do
        expect(no_win_game.mix_dg_rl.winner).to eql(nil)
      end

      it 'contains no object filled with mixed right higher diagonal in board' do
        expect(no_win_game.mix_dg_rh.winner).to eql(nil)
      end

      it 'contains no object at one piece only in board' do
        expect(no_win_game.only_one.winner).to eql(nil)
      end

      it 'contains no object at two pieces only in board' do
        expect(no_win_game.only_two.winner).to eql(nil)
      end

      it 'contains no object at spreaded match 1 in board' do
        expect(no_win_game.spread_1.winner).to eql(nil)
      end

      it 'contains no object at spreaded match 2 in board' do
        expect(no_win_game.spread_2.winner).to eql(nil)
      end

      it 'contains no object at spreaded match 3 in board' do
        expect(no_win_game.spread_3.winner).to eql(nil)
      end

      it 'contains no object at spreaded match 4 in board' do
        expect(no_win_game.spread_4.winner).to eql(nil)
      end

      it 'contains no object at spreaded match 5 in board' do
        expect(no_win_game.spread_5.winner).to eql(nil)
      end

      it 'contains no object at spreaded match 6 in board' do
        expect(no_win_game.spread_6.winner).to eql(nil)
      end

      it 'contains no object at default board' do
        expect(no_win_game.default.winner).to eql(nil)
      end
    end
  end # describe '@winner' do
end
