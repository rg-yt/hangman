class Game
  attr_accessor :guesses

  def initialize
    @guesses = 1
    @secret_word = secret_word
    @check = Array.new(@secret_word.length, '_')
  end

  def play
    until gameover?
      print "#{@check}\n"
      guess_feedback(player_guess)
    end
  end

  private

  def secret_word
    word = ''
    p word = File.readlines('words.txt').sample.strip until (6..12).include?(word.length)
    word
  end

  def guess_feedback(guess)
    array = []
    word = @secret_word
    word.length.times do |number|
      array << number if word[number] == guess
    end
    array.each do |index|
      @check[index] = guess
    end
  end

  def gameover?
    if @check == @secret_word.split('')
      puts 'You win!'
      true
    elsif @guesses > 6
      puts 'Better luck next time!'
      true
    end
  end

  def player_guess
    gets.chomp.downcase
  end
end
game = Game.new
game.play
