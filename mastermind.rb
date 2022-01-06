class Player
    attr_reader :name
    attr_accessor :type

  def initialize(name)
    @name = name
    @type = nil
  end



end

class Computer
    attr_reader :name


    CODE_POSSIBILITIES = %w[A B C D E F]

    def initialize
        @name = 'Computer'
        @guesses = []
    end

    def guess
        c_guess = CODE_POSSIBILITIES.sample(4).join("")
        while @guesses.include?(c_guess)
            c_guess = CODE_POSSIBILITIES.sample(4).join("")
        end
        @guesses.push(c_guess)
        c_guess
    end



end

class Game
  CODE_POSSIBILITIES = %w[A B C D E F]

  def initialize
    puts "Welcome to Mastermind.  The goal of this game is to guess a secret code.  The secret code is made up of four letters among A, B, C, D, E, F, in no particular order.  In this game, you will select either the secret code, or guess the secret code.  Let's start with something easy:"
    puts 'What is your name?'
    name = gets.chomp
    @player1 = Player.new(name)
    if code_guesser_or_creator == 'creator'
        @player2 = Computer.new
    end
    @guess_counts = 12
  end

  def code_guesser_or_creator
    puts "#{@player1.name}, would you like to guess the code or create the code?"
    puts "Select 1 to guess the code, or 2 to create the code"
    input = gets.chomp.to_i

    if input == 1
        @code = CODE_POSSIBILITIES.sample(4)
        @player1.type = 'guesser'
        "guesser"
    else
        get_code
        @player1.type = 'creator'
        "creator"
    end
  end

  def get_code
    puts 'Enter the code without spaces.  The code is made up of letters A,B,C,D,E,F'
    code = gets.chomp
    if code_format_correct?(code)
        code
      else
        puts 'Not Correct Format.  Try again'
          get_code
      end
      @code = code
      code
  end

  def get_guess
    if @player1.type == 'guesser'
        puts 'Enter your guess without spaces'
        answer = gets.chomp
        if answer_format_correct?(answer)
        answer
        else
        puts 'Not Correct Format.  Try again'
            get_guess
        end
        answer
    else
        code = @player2.guess
        puts code
        code
    end
  end

  def code_format_correct?(code)
    return false if code.length != 4
    return false if code.split("").uniq.length != 4
    code_array = code.split("")
    unless (code_array - CODE_POSSIBILITIES).empty?
        puts 'enter the proper parameters'
          return false
      end
      true

  end

  def answer_format_correct?(answer)
    return false if answer.length != @code.length

    answer_array = answer.split('')
    unless (answer_array - CODE_POSSIBILITIES).empty?
      puts 'enter the proper parameters'
        return false
    end
    true
  end

  def feedback(answer)
    # + is correct letter and correct space
    # * is correct letter but not correct space
    # answer is a string
    answer_array = answer.split('')
    returned_array = []

    answer_array.each_with_index do |_val, i|
      returned_array.push('+') if answer_array[i] == @code[i]
    end



    stars = 0
    answer_array.uniq.each do |ele|
        if @code.include?(ele)
            stars += 1
        end
    end


    stars -= returned_array.count
    stars.times { |x| returned_array.push('*') }
    puts returned_array.join
    returned_array.join
  end

  def winner
    if feedback(get_guess) == '++++'
      puts 'You Win!'
        return true
    end
    puts "You have #{@guess_counts -= 1} guesses left"
  end

  def game_over?
    if @guess_counts == 0
      puts 'You are out of guesses.  Game over'
      puts "The code was #{@code}"
        true
    else
      winner
    end
  end
end
