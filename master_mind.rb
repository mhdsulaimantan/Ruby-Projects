# frozen_string_literal: true

module ColorList
  COLORS = %w[red blue green purple white yellow black brown].freeze

  def random_color
    COLORS.sample
  end
end

class Player
  include ColorList
  @@secret_list = []
  
  def initialize(player_id)
    @player_id = player_id
  end

  def create_secret_list
    # computer is the gusser
    if @player_id == 1
      # human will enter the secret list
      puts 'The gusser is Computer, So, you as a human need to enter your secret color list...'
      COLORS.each_with_index do |color, ind|
        puts "#{ind}) #{color}"
      end
      puts "Enter 4 color's number..."
      until @@secret_list.length == 4
        color_num = gets.chomp
        if (0..COLORS.length - 1).include?(color_num.to_i)
          @@secret_list.push(COLORS[color_num.to_i])
        else
          puts 'Wrong number. Try again!!!'
        end
      end
    # Human is the gusser
    else
      4.times do |_num|
        @@secret_list.push(random_color)
      end
    end
    @@secret_list
  end

  def create_guesser_list(guess_list = [])
    if @player_id == 1
      puts 'Computer is the gusser. So, it will generate a random list...'
      4.times do |_num|
        guess_list.push(random_color)
      end
      puts "computer list is #{guess_list}"

    else
      puts 'Human is the gusser. So, please enter 4 Colors to pridect colors secret list...'
      COLORS.each_with_index do |color, ind|
        puts "#{ind}) #{color}"
      end
      until guess_list.length == 4
        color_num = gets.chomp
        if (0..COLORS.length - 1).include?(color_num.to_i)
          guess_list.push(COLORS[color_num.to_i])
        else
          puts 'Wrong number. Try again!!!'
        end
      end
      puts "your list is #{guess_list}"
    end
    guess_list
  end
end

class MasterMind
  @@win = false

  attr_accessor :win

  def start
    puts 'Who is the Gusser?'
    puts '1)Computer.'
    puts '2)Human.'
    puts 'please pick a number between 1 and 2.'
    gusser = gets.chomp
    if [1, 2].include?(gusser.to_i)
      @player = Player.new(gusser.to_i)
      @secret_list = @player.create_secret_list
    else
      puts 'Wrong choice!!!'
      start
    end
  end

  def play
    puts 'The Gusser should predict the secret list'
    @guess_list = @player.create_guesser_list
  end

  def feedback
    same_pos = 0
    diff_pos = 0
    (0..4).each do |i|
      if @secret_list[i..].include?(@guess_list[i])
        if @secret_list[i] == @guess_list[i]
          same_pos += 1
        else
          diff_pos += 1
        end
      end
    end
    puts "There is/are #{same_pos} color/s in the right position."
    puts "There is/are #{diff_pos} color/s right but in the wrong position."
    puts "There is/are #{4 - (same_pos + diff_pos)} color/s wrong!"

    # win the game
    @@win = true if same_pos == 4
  end
end

puts '---- Welcome to MasterMind Game ----'
game = MasterMind.new
game.start
puts 'Colors Secret List has been created. LETS PLAY NOW :)'
round = 1
until round == 13
  puts "----------------------- #{round} round -----------------------"
  game.play
  game.feedback

  # is the player won?
  if game.win
    puts 'Congratulation. The player has won ^_^.'
    break
  end
  round += 1
end
puts 'No one guessed the colors secret list *_*.' if round == 13
