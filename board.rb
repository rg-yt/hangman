# Board module is only for displaying the gameboard in a pleasing way
module Board
  def main_display(input)
    input.each_with_index do |char,index|
      if index == input.length - 1
        print "| #{char} |\n"
      elsif index.zero?
        print "| #{char} "
      else
        print "| #{char} "
      end
    end
    puts
  end

  def display_letters(input)
    puts 'Current letters used:'
    puts '|  |' if input.length.zero?
    main_display(input)
  end

  def display_gameover(input,result)
    puts 'The word was:'
    main_display(input)
    puts 'Better luck next time!'if result == 'lose'
    puts 'You win!' if result == 'win'
    true
  end

  def display_bar
    puts '____________________________________________________________________________'
    puts
  end
end