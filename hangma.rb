class Hangman

  def initialize(guessing_plaeyr, checking_player)
    if guessing_plaeyr == "Computer"
      @guessing = ComputerPlaeyr.new
    else
      @guessing = HumanPlayer.new
      #@secret_word = CompPlaeyr.new
    end

    if checking_player == "Computer"
      @checking = ComputerPlaeyr.new
    else
      @checking = HumanPlayer.new
    end
    @showed_word = "_" * @checking.receive_secret_length
    #@user_letter = HumanPlayer.new
  end

  def play
    puts "Guess the secret word"
    p @showed_word
    #sp @guessing
     while @showed_word.include?('_')
       p @showed_word
       letter = @guessing.user_choice(@showed_word.length)
       index = @checking.give_index(letter)
       handle_guess_response(letter,index)
       update_showed_word(letter, index)
     end
     puts @showed_word
     puts "Congrats!"

  end

  def handle_guess_response(letter, index)
    if index.empty?
      puts "Sorry, it does not include #{letter}"
    else
      puts "Yes, it include #{letter}"
    end
  end

  def update_showed_word(letter, index)
    return nil if index.empty?
    index.each do |idx|
      @showed_word[idx] = letter
    end
    nil
  end

end

class HumanPlayer
  def initialize
    @secret_length = 0
    @secret_word = nil
    #@user_guess = user_choise
  end

  def user_choice(secret_length)
    puts "Please choose a letter"
    user_letter = gets.chomp
  end

  def receive_secret_length
    puts "How long your word?"
    @secret_length = gets.chomp.to_i
  end

  def give_index(letter)
    indexes = []
    puts "Computer chose '#{letter}', does your word include any? (y/n)?"
    result = gets.chomp.downcase
    return indexes if result == "n"

    while true
      puts "What index is '#{letter}' located? (one at a time) ['q' if no more]"
      answer = gets.chomp.downcase
      break if answer == "q"
      indexes << answer.to_i - 1
    end

    indexes
  end
end


class ComputerPlaeyr
  def initialize
    @dictionary = File.readlines('dictionary.txt')
    @secret_word = @dictionary.sample.chomp
    @already_guessed = []
  end

  def receive_secret_length
    @secret_word.length
  end

  def give_index(letter)
    index = []
    @secret_word.each_char.with_index do |ch, idx|
      if ch == letter
        index << idx
      end
    end
    index
  end

  def user_choice(secret_length)
    while true
      possible_choices = []
      @dictionary.each do |word|
        if word.chomp.length == secret_length
          possible_choices << word.chomp
        end
      end

      letter = possible_choices.sample.split("").sample

      if @already_guessed.include?(letter)
        next
      else
        @already_guessed << letter
        return letter
      end
    end
  end
end
