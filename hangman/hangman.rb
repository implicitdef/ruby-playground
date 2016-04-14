
class Game

  def initialize(words)
    @word = words
      .select{|w| w.size > 8}
      .sample
    @guesses = 0
    @letters_so_far = Array.new
  end

  def launch
    play
  end

  private

  def play
    print_current_state
    input = askForLetter
    if @letters_so_far.include?(input)
      puts "You have already found this letter"
      play
    elsif @word.include?(input)
      puts "That's a match"
      @letters_so_far.push(input)
      @guesses += 1
      if (@word.split("").uniq.size == @letters_so_far.size)
        puts @word
        puts "Well played ! You found the word in #{@guesses} guesses"
      else
        play
      end
    else
      puts "Nope #{input} is not in the word. Try again"
      @guesses += 1
      play
    end
  end

  def askForLetter
    puts "Please pick a letter"
    l = gets.chomp
    if l.length == 1
      l
    else
      puts "Please enter exactly one letter"
      askForLetter
    end
  end

  def print_current_state
    puts (@word.split("").map do |val|
      if @letters_so_far.include?(val)
        val
      else
        "."
      end
    end).join("") + " (#{@guesses})"
  end

end

g = Game.new(File.readlines('words.txt').map{|l| l.chomp})
g.launch
