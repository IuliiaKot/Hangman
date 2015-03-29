class Hangman
 def initialie
   @secret_word = ComputerPlaeyr.new
   @showed_word = '_' * @secret_word.length
 end

 def play
   p @showed_word
 end
end

class HumanPlayer

end


class ComputerPlaeyr

  def initialize
    @dictionary = File.readlines('dictionary.txt')
    @secret_word = @dictionary.sample.chomp
  end
end
