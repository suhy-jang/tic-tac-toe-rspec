# frozen_string_literal: true

require './lib/player.rb'
require './lib/game.rb'

RSpec.describe Game do
  win_cases_num = 8
  no_win_cases_num = 17

  let(:players) do
    [
      Player.new('EBUKA', :O),
      Player.new('SUH', :X)
    ]
  end
  let(:primary_player) { players.sample }
  let(:secondary_player) { players.reject { |elem| elem == primary_player }.sample }
  let(:p) { primary_player.stone }
  let(:s) { secondary_player.stone }
  let(:swap_stone_once) { [s, p] }
  let(:swap_stone_twice) { [p, s] }
  let(:win_cases) do
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

  let(:no_win_cases) do
    [
      double(state: [p, s, p, 4, 5, 6, 7, 8, 9]), # mix_row_top
      double(state: [1, 2, p, 4, 5, s, 7, 8, p]), # mix_col_right
      double(state: [1, 2, 3, 4, 5, 6, p, s, p]), # mix_row_bottom
      double(state: [p, 2, 3, s, 5, 6, p, 8, 9]), # mix_col_left
      double(state: [1, s, 3, 4, p, 6, 7, s, 9]), # mix_col_mid
      double(state: [1, 2, 3, s, p, s, 7, 8, 9]), # mix_row_mid
      double(state: [s, 2, 3, 4, p, 6, 7, 8, s]), # mix_main_diag
      double(state: [1, 2, s, 4, p, 6, s, 8, 9]), # mix_anti_diag
      double(state: [p, 2, 3, 4, 5, 6, 7, 8, 9]), # only_one
      double(state: [p, p, 3, 4, 5, 6, 7, 8, 9]), # only_two
      double(state: [1, p, p, p, 5, 6, 7, 8, 9]), # spread_1
      double(state: [1, 2, p, p, p, 6, 7, 8, 9]), # spread_2
      double(state: [1, 2, 3, 4, p, p, p, 8, 9]), # spread_3
      double(state: [1, 2, 3, 4, 5, p, p, p, 9]), # spread_4
      double(state: [p, 2, 3, 4, 5, 6, 7, p, p]), # spread_5
      double(state: [p, p, 3, 4, 5, 6, 7, 8, p]), # spread_6
      double(state: [1, 2, 3, 4, 5, 6, 7, 8, 9]) # default
    ]
  end

  let(:win_game) do
    [
      Game.new(primary_player, secondary_player, win_cases[0]),
      Game.new(primary_player, secondary_player, win_cases[1]),
      Game.new(primary_player, secondary_player, win_cases[2]),
      Game.new(primary_player, secondary_player, win_cases[3]),
      Game.new(primary_player, secondary_player, win_cases[4]),
      Game.new(primary_player, secondary_player, win_cases[5]),
      Game.new(primary_player, secondary_player, win_cases[6]),
      Game.new(primary_player, secondary_player, win_cases[7])
    ]
  end

  let(:no_win_game) do
    [
      Game.new(primary_player, secondary_player, no_win_cases[0]),
      Game.new(primary_player, secondary_player, no_win_cases[1]),
      Game.new(primary_player, secondary_player, no_win_cases[2]),
      Game.new(primary_player, secondary_player, no_win_cases[3]),
      Game.new(primary_player, secondary_player, no_win_cases[4]),
      Game.new(primary_player, secondary_player, no_win_cases[5]),
      Game.new(primary_player, secondary_player, no_win_cases[6]),
      Game.new(primary_player, secondary_player, no_win_cases[7]),
      Game.new(primary_player, secondary_player, no_win_cases[8]),
      Game.new(primary_player, secondary_player, no_win_cases[9]),
      Game.new(primary_player, secondary_player, no_win_cases[10]),
      Game.new(primary_player, secondary_player, no_win_cases[11]),
      Game.new(primary_player, secondary_player, no_win_cases[12]),
      Game.new(primary_player, secondary_player, no_win_cases[13]),
      Game.new(primary_player, secondary_player, no_win_cases[14]),
      Game.new(primary_player, secondary_player, no_win_cases[15]),
      Game.new(primary_player, secondary_player, no_win_cases[16])
    ]
  end

  let(:original_turn) { no_win_game[0].turn }
  let(:changed_turn) { [0, 1].reject { |p| p == original_turn }.sample }

  before do
    0.upto(win_cases_num - 1) do |e|
      win_game[e].test_winner_status_update(primary_player)
    end
    0.upto(no_win_cases_num - 1) do |e|
      no_win_game[e].test_winner_status_update(primary_player)
    end
    original_turn
  end

  describe '@winner after #test_winner_status_update' do
    context 'when no winner' do
      0.upto(no_win_cases_num - 1) do |e|
        it "contains no object - case, #{e}" do
          expect(no_win_game[e].winner).to_not eql(primary_player)
        end
      end
    end

    context 'when winner' do
      0.upto(win_cases_num - 1) do |e|
        it "contains winner object - case, #{e}" do
          expect(win_game[e].winner).to eql(primary_player)
        end
      end
    end
  end

  describe '#change_turn' do
    it 'returns 0 or 1 with changed turn once' do
      expect(no_win_game[0].test_change_turn).to eql(changed_turn)
    end

    it 'returns 0 or 1 with changed turn twice' do
      no_win_game[0].test_change_turn
      expect(no_win_game[0].test_change_turn).to eql(original_turn)
    end
  end

  describe '#swap_stone' do
    it 'returns an array the players pieces are swapped once' do
      expect(no_win_game[0].test_swap_stone).to eql(swap_stone_once)
    end

    it 'returns an array the players pieces are swapped twice' do
      no_win_game[0].test_swap_stone
      expect(no_win_game[0].test_swap_stone).to eql(swap_stone_twice)
    end
  end
end
