class Player
  def initialize(name)
    @name = name
  end
end

class Game
  CODE_POSSIBILITIES = %w[A B C D E F]

  def initialize
    puts 'What is your name?'
    name = gets.chomp
    @player1 = Player.new(name)
    @code = CODE_POSSIBILITIES.sample(3)
    @guess_counts = 100
  end

  def get_guess
    puts 'Enter your guess without spaces'
    answer = gets.chomp
    if answer_format_correct?(answer)
      answer
    else
      puts 'Not Correct Format.  Try again'
        get_guess
    end
    answer
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
    @code.each_with_index do |_val, i|
      stars += 1 if @code.count(answer_array[i]) > 0
    end

    stars -= returned_array.count
    stars.times { |_x| returned_array.push('*') }
    puts returned_array.join
    returned_array.join
  end

  def winner
    if feedback(get_guess) == '+++'
      puts 'You Win!'
        return true
    end
    puts "You have #{@guess_counts -= 1} guesses left"
  end

  def game_over?
    if @guess_counts == 0
      puts 'You are out of guesses.  Game over'
        true
    else
      winner
    end
  end
end
