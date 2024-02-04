class Hangman
  def initialize
    @secret_word = nil
    @guessed_letters = []
    @remaining_guesses = 6
    @dictionary = nil

    load_dictionary
    choose_secret_word
    puts @secret_word
  end


  def load_dictionary
    @dictionary = File.readlines("google-10000-english-no-swears.txt").map(&:chomp).select { |word| word.length.between?(5, 5) }
  end
  def choose_secret_word
    @secret_word = @dictionary.sample
  end

  def display_word
    displayed_word = ""
    @secret_word.each_char do |char|
      if @guessed_letters.include?(char)
        displayed_word += char
      else
        displayed_word += "_"
      end
    end
    return displayed_word
  end

  def get_guess
    loop do
      puts "Enter a letter (or 'save' to save the game):"
      guess = gets.chomp.upcase
  
      if guess == "SAVE"
        return "save"
      elsif guess.length == 1 && !@guessed_letters.include?(guess)
        return guess
      else
        puts "Invalid input. Please enter a single letter or 'save'."
      end
    end
  end

  def check_guess(letter)
    if @secret_word.include?(letter)
      @guessed_letters << letter
      puts "Correct guess!"
      puts display_word
      return true
    else
      @remaining_guesses -= 1
      puts "Incorrect guess. You have #{@remaining_guesses} guesses left."
      return false
    end
  end

  def play
    while @remaining_guesses > 0 && !@secret_word.chars.all? { |char| @guessed_letters.include?(char) }
      puts display_word
  
      guess = get_guess
  
      if guess == "save"
        save_game
      else
        check_guess(guess)
      end
  
      if @remaining_guesses == 0
        puts "You're out of guesses! The word was #{@secret_word}."
      elsif @secret_word.chars.all? { |char| @guessed_letters.include?(char) }
        puts "Congratulations! You guessed the word #{@secret_word}."
      end
    end
  end
end

hangman = Hangman.new
hangman.play

