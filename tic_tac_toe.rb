# frozen_string_literal: true

# takeing a move
class Play
  def initialize(player)
    @player = player
  end

  def new_move
    Game.new.add_move(@player, move_position)
  end

  private

  def move_position
    p 'pick a number between (0 - 2) for row...'
    row_move = gets.chomp
    p 'pick a number between (0 - 2) for column...'
    col_move = gets.chomp
    return [row_move.to_i, col_move.to_i] if check_pos(row_move, col_move)

    move_position
  end

  def check_pos(row, col)
    begin
      row = row.to_i
      col = col.to_i
      if (0..2).include?(row) && (0..2).include?(col)
        board = Game.new.get_board
        unless board[row][col].nil?
          p 'This position is already taken. please, try again!!'
          return false
        end
      else
        p 'Please choose numbers between (0 - 2)'
        return false
      end
    rescue StandardError
      p 'You entered wrong positon. please, try again'
      return false
    end

    true
  end
end

class Game
  @@board = Array.new(3) { Array.new(3) }

  def get_board
    @@board
  end

  def add_move(move_type, pos_arr)
    @@board[pos_arr[0]][pos_arr[1]] = move_type
  end

  def check_win?
    (0..2).each do |i|
      if @@board[i].all? { |r_ele| !r_ele.nil? && r_ele == @@board[i][0] }
        return true
      else
        (0..2).each do |j|
          if i.zero? && ((!@@board[i][j].nil? && (@@board[i][j] == @@board[i + 1][j]) && (@@board[i + 1][j] == @@board[i + 2][j])) ||
                 (!@@board[0][0].nil? && (@@board[0][0] == @@board[1][1]) && (@@board[1][1] == @@board[2][2])) ||
                 (!@@board[0][2].nil? && (@@board[0][2] == @@board[1][1]) && (@@board[1][1] == @@board[2][0])))
            return true
          end
        end
      end
    end
    false
  end

  def board_pattern
    p "#{@@board[0][0] || ' '} | #{@@board[0][1] || ' '} | #{@@board[0][2] || ' '}"
    p '----------'
    p "#{@@board[1][0] || ' '} | #{@@board[1][1] || ' '} | #{@@board[1][2] || ' '}"
    p '----------'
    p "#{@@board[2][0] || ' '} | #{@@board[2][1] || ' '} | #{@@board[2][2] || ' '}"
  end
end

game = Game.new

i = 0
while i <= 8

  if i.even?
    move = 'X'
    p '-- Player 1 Turn --'
  else
    move = 'O'
    p '-- Player 2 Turn --'
  end
  player = Play.new(move)

  player.new_move
  p '************'
  game.board_pattern
  p '************'

  if game.check_win? == true
    if move == 'X'
      p 'Player 1 is the winner'
    else
      p 'Player 2 is the winner'
    end
    break
  end
  i += 1
end

p 'No One Won!!!!' if i == 8
