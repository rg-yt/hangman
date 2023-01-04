
module Board
  def display_tracker(input)
    
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
    puts "Current letters used:"
    puts '|  |' if input.length == 0
    input.each_with_index do |char,index|
      if index == input.length - 1
        print "| #{char} |\n"
      elsif index.zero? 
        print "| #{char} "
      else
        print "| #{char} "
      end
    end
  end
end