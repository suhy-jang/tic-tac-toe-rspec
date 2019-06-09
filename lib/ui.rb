module UserInterface
  def self.inform_begin_message
    border = '-----------------------------------------------------------------'.center(80)
    line1 = 'Tic Tac Toe is a paper-and-pencil game for two players, X and O, '.center(80)
    line2 = 'who take turns marking the spaces in a 3×3 grid.'.center(80)
    line3 = 'The player who succeeds in placing three of their marks in a '.center(80)
    line4 = 'horizontal, vertical, or diagonal row wins the game.'.center(80)
    puts border, line1, line2, line3, line4, border
  end

  def self.ask_name(num)
    user_input = ''
    loop do
      print "Player #{num} name: ".rjust(50)
      user_input = gets.chomp
      break unless user_input.empty? || user_input.scan(/[a-zA-Z]/).empty?

      type_again_name
    end
    user_input.upcase
  end

  def self.type_again_name
    puts 'Please type in your name (with alphabet)!'.rjust(50)
  end

  def self.ask_first_player_name(p1_name, p2_name, first_sym)
    puts "Who wants to play with '#{first_sym}' (first player)".rjust(50)
    name = nil
    loop do
      print "Type the name(#{p1_name} or #{p2_name}): ".rjust(50)
      name = gets.chomp.upcase
      break if [p1_name, p2_name].include?(name)
    end
    name
  end

  def self.ask_position(name, stone)
    print "[ #{name}'s turn! ]\n".rjust(50)
    print "Where would you like to put your piece '#{stone}'?: ".rjust(50)
    gets.chomp.to_i
  end

  def self.inform_result(winner_name = nil, winner_stone = nil)
    puts 'Game Over!'.rjust(50)
    return puts '[ TIE! ]'.rjust(50) if winner_name.nil?

    puts "[ #{winner_name} (#{winner_stone}) WON! ]".rjust(50)
  end

  def self.throw_wrong_place_error(position = nil)
    return puts "'#{position}' already occupied!".rjust(50) if position

    puts 'Please input a correct number'.rjust(50)
    puts 'between 1 and 9 (not occupied)'.rjust(50)
  end

  def self.inform_success(player_stone, position)
    puts "Successfully placed '#{player_stone}' at position '#{position}'".rjust(50)
  end

  def self.display_board(state)
    board = ''
    line = "+-------+-------+-------+\n".rjust(55)
    wall = "|       |       |       |\n".rjust(55)
    row1 = "|   #{state[0]}   |   #{state[1]}   |   #{state[2]}   |\n".rjust(55)
    row2 = "|   #{state[3]}   |   #{state[4]}   |   #{state[5]}   |\n".rjust(55)
    row3 = "|   #{state[6]}   |   #{state[7]}   |   #{state[8]}   |\n".rjust(55)
    board << line << wall << row1 << wall
    board << line << wall << row2 << wall
    board << line << wall << row3 << wall << line
    puts board
  end
end
