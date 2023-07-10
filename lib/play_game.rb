# frozen_string_literal: true

# This class implements the game flow
class PlayGame
  attr_reader :first_player, :second_player, :board

  def initialize(args)
    @first_player = args[:first_player]
    @second_player = args[:second_player]
    @board = args[:board]
  end

  def play_game
    puts board
    loop do
      first_player_move
      break if winner_check

      second_player_move
      break if winner_check
    end
    play_again
  end

  private

  def first_player_move
    puts "#{first_player.name} make your move!"
    board.process_player_move(first_player.sign, first_player.make_move(board))
  end

  def second_player_move
    puts "#{second_player.name} make your move!"
    board.process_player_move(second_player.sign, second_player.make_move(board))
  end

  def check_left_moves
    return unless board.move_board.any? { |arr| arr.any?(Integer) } == false

    puts 'It\'s a draw!'
    true
  end

  def first_player_won
    "Congratulations! #{first_player.name} won the game!"
  end

  def second_player_won
    "Congratulations! #{second_player.name} won the game!"
  end

  def first_column
    [].push(board.board_for_check[0][0], board.board_for_check[1][0], board.board_for_check[2][0])
  end

  def second_column
    [].push(board.board_for_check[0][1], board.board_for_check[1][1], board.board_for_check[2][1])
  end

  def third_column
    [].push(board.board_for_check[0][2], board.board_for_check[1][2], board.board_for_check[2][2])
  end

  def left_diagonal
    [].push(board.board_for_check[0][0], board.board_for_check[1][1], board.board_for_check[2][2])
  end

  def right_diagonal
    [].push(board.board_for_check[0][2], board.board_for_check[1][1], board.board_for_check[2][0])
  end

  def check_arr(first_column, second_column, third_column, left_diagonal, right_diagonal)
    check_arr = board.board_for_check.push(first_column, second_column, third_column, left_diagonal, right_diagonal)
    check_arr.any? do |arr|
      if arr.all?(first_player.sign)
        puts first_player_won
        return true
      elsif arr.all?(second_player.sign)
        puts second_player_won
        return true
      end
    end
  end

  def winner_check
    return unless check_arr(first_column, second_column, third_column, left_diagonal, right_diagonal)\
    || check_left_moves

    true
  end

  def play_again
    puts 'Do you want to play again?(yes or anything)'
    answer = gets.chomp
    return unless answer.downcase == 'yes'

    board.move_board = board.board.map(&:clone)
    play_game
  end
end
