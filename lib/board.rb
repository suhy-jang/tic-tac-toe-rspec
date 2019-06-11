class Board
  attr_reader :state

  def initialize
    @occupy_num = 0
    @state = (1..9).to_a
  end

  def full?
    @state.length == @occupy_num
  end

  def update_state(game_piece, position)
    @state[position - 1] = game_piece
    increase_occupy_num
  end

  def in_range?(position)
    (1..9).include? position
  end

  def occupied?(position)
    @state[position - 1].class != Integer
  end

  def test_occupy_num(num)
    @occupy_num = num
  end

  private

  def increase_occupy_num
    @occupy_num += 1
  end
end
