class Hangman
  def initialize
    @secret_word = secret_word
    @guessed_letters = guessed_letters
    @remaining_guesses = remaining_guesses
    @dictionary = dictionary

    load_dictionary
    choose_secret_word
  end

  def load_dictionary
    @dictionary = File.readlines("google-10000-english-no-swears.txt").map(&:chomp).select { |word| word.length.between?(5, 12) }
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
end
