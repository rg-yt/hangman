# 
require 'yaml'
require './board'

# Game
class Game
  include Board
  attr_accessor :guesses

  def initialize
    @guesses = 1
    @secret_word = secret_word
    @guess_tracker = Array.new(@secret_word.length, '_')
    @letters_guessed = []
  end

  def play
    load?
    puts "Let's play hangman!"
    until gameover? || save?
      display_tracker(@guess_tracker)
      display_letters(@letters_guessed)
      @current_guess = player_input
      guess_feedback
    end
  end

  private

  def secret_word
    word = ''
    word = File.readlines('words.txt').sample.strip until (6..12).include?(word.length)
    word
  end

  def guess_feedback
    array = []
    @guesses += 1 unless @secret_word.include? @current_guess
    @secret_word.length.times do |number|
      array << number if @secret_word[number] == @current_guess
    end
    array.each do |index|
      @guess_tracker[index] = @current_guess
    end
    @guess_tracker
  end

  def player_input
    print 'Enter a letter:'
    input = gets.chomp.downcase
    while (@letters_guessed.include?(input) || input.length != 1) && input != 'save'
      print 'Enter a valid character:'
      input = gets.chomp.downcase
    end
    puts
    @letters_guessed << input unless input == 'save'
    input
  end

  def gameover?
    if @guess_tracker == @secret_word.split('')
      puts 'You win!'
      print "#{@guess_tracker}\n"
      true
    elsif @guesses > 6
      puts 'The word was:'
      display_tracker(@secret_word.split(''))
      puts 'Better luck next time!'
      true
    end
  end

  def save?
    return unless @current_guess == 'save'

    print 'Saving game'
    3.times do
      sleep 1
      print '.'
    end
    save_game
    puts "\nSaved\n"
    true
  end

  def load?
    puts 'Would you like to load a game? (yes/no)'
    load = gets.chomp.downcase
    return if load != 'yes'

    load_game
  end

  def save_game
    File.open('save.yaml', 'w') { |file| file.write(to_yaml) }
  end

  def to_yaml
    YAML.dump({
      :guesses => @guesses,
      :secret_word => @secret_word,
      :guess_tracker => @guess_tracker,
      :letters_guessed => @letters_guessed
    })
  end

  def load_game
    begin
      data = YAML.load(File.open('save.yaml', 'r'))
      @guesses = data[:guesses] 
      @secret_word = data[:secret_word]
      @guess_tracker = data[:guess_tracker]
      @letters_guessed = data[:letters_guessed]
      puts 'The game has been loaded!'
    rescue
      puts 'There is no saved game!'
      load?
    end
  end
end
game = Game.new
game.play
