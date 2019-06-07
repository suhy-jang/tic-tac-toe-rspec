# frozen_string_literal: true

require './lib/player.rb'
require './lib/board.rb'
require './lib/game.rb'

RSpec.describe Game do
  let(:player1) { double(name: 'EBUKA', stone: :O) }
  let(:player2) { double(name: 'SUH', stone: :X) }
  let(:oe) { player1.stone }
  let(:ex) { player2.stone }
  let(:board) { Board.new }
  let(:game) { Game.new(player2, player2, board) }
  let(:set_row_top_only1_1) { board.state = [oe, 2, 3, 4, 5, 6, 7, 8, 9] }
  let(:set_row_top_only2_2) { board.state = [ex, ex, 3, 4, 5, 6, 7, 8, 9] }
  let(:set_row_top_1) { board.state = [oe, oe, oe, 4, 5, 6, 7, 8, 9] }
  let(:set_row_mid_2) { board.state = [1, 2, 3, ex, ex, ex, 7, 8, 9] }
  let(:set_row_bottom_1) { board.state = [1, 2, 3, 4, 5, 6, oe, oe, oe] }
  let(:set_col_left_1) { board.state = [oe, 2, 3, oe, 5, 6, oe, 8, 9] }
  let(:set_col_mid_2) { board.state = [1, ex, 3, 4, ex, 6, 7, ex, 9] }
  let(:set_col_right_1) { board.state = [1, 2, oe, 4, 5, oe, 7, 8, oe] }
  let(:set_diag_r_low_1) { board.state = [oe, 2, 3, 4, oe, 6, 7, 8, oe] }
  let(:set_diag_r_higher_2) { board.state = [1, 2, ex, 4, ex, 6, ex, 8, 9] }
  let(:set_rand_1) { board.state = [oe, ex, oe, 4, 5, 6, 7, oe, 9] }
  let(:set_rand_2) { board.state = [1, oe, 3, 4, 5, 6, oe, ex, oe] }
  let(:set_rand_3) { board.state = [oe, 2, 3, ex, 5, ex, oe, 8, 9] }
  let(:set_rand_4) { board.state = [1, 2, oe, oe, 5, ex, 7, 8, oe] }

  describe '@winner' do
    context 'with not enough pieces to be winner' do
      context 'when it starts' do
        it 'returns no object' do
          game.test_winner_status_update(player1)
          expect(game.winner).to_not eql(player1)
        end
      end

      context 'with one piece only' do
        before do
          set_row_top_only1_1
          game.test_winner_status_update(player1)
        end

        it 'returns no object' do
          expect(game.winner).to_not eql(player1)
        end
      end

      context 'with two pieces only' do
        before do
          set_row_top_only2_2
          game.test_winner_status_update(player2)
        end

        it 'returns no object' do
          expect(game.winner).to_not eql(player2)
        end
      end
    end

    context 'with putting piece at spreaded place' do
      context 'on the random place 1' do
        before do
          set_rand_1
          game.test_winner_status_update(player1)
        end
        it 'returns no object' do
          expect(game.winner).to_not eql(player1)
        end
      end

      context 'on the random place 2' do
        before do
          set_rand_2
          game.test_winner_status_update(player2)
        end
        it 'returns no object' do
          expect(game.winner).to_not eql(player2)
        end
      end

      context 'on the random place 3' do
        before do
          set_rand_3
          game.test_winner_status_update(player1)
        end
        it 'returns no object' do
          expect(game.winner).to_not eql(player1)
        end
      end

      context 'on the random place 4' do
        before do
          set_rand_4
          game.test_winner_status_update(player2)
        end
        it 'returns no object' do
          expect(game.winner).to_not eql(player2)
        end
      end
    end

    context 'with three same pieces' do
      context 'on the top row' do
        before do
          set_row_top_1
          game.test_winner_status_update(player1)
        end
        it 'returns winner object' do
          expect(game.winner).to eql(player1)
        end
      end

      context 'on the mid row' do
        before do
          set_row_mid_2
          game.test_winner_status_update(player2)
        end
        it 'returns winner object' do
          expect(game.winner).to eql(player2)
        end
      end

      context 'on the bottom row' do
        before do
          set_row_bottom_1
          game.test_winner_status_update(player1)
        end
        it 'returns winner object' do
          expect(game.winner).to eql(player1)
        end
      end

      context 'on the left column' do
        before do
          set_col_left_1
          game.test_winner_status_update(player1)
        end
        it 'returns winner object' do
          expect(game.winner).to eql(player1)
        end
      end

      context 'on the mid column' do
        before do
          set_col_mid_2
          game.test_winner_status_update(player2)
        end
        it 'returns winner object' do
          expect(game.winner).to eql(player2)
        end
      end

      context 'on the right column' do
        before do
          set_col_right_1
          game.test_winner_status_update(player1)
        end
        it 'returns winner object' do
          expect(game.winner).to eql(player1)
        end
      end

      context 'on the left higher right lower diagonal' do
        before do
          set_diag_r_low_1
          game.test_winner_status_update(player1)
        end
        it 'returns winner object' do
          expect(game.winner).to eql(player1)
        end
      end

      context 'on the left lower right higher diagonal' do
        before do
          set_diag_r_higher_2
          game.test_winner_status_update(player2)
        end
        it 'returns winner object' do
          expect(game.winner).to eql(player2)
        end
      end
    end # context 'with three same pieces' do
  end # describe '@winner' do
end
