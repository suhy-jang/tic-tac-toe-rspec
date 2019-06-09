# frozen_string_literal: true

class Player
  attr_accessor :name, :stone
  def initialize(name, stone)
    @name = name
    @stone = stone
  end
end
