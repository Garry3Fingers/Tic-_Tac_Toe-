# frozen_string_literal: true

# This class checks the winner of the game
class WinnerCheck
  attr_reader :first_player_sign, :second_player_sign, :first_player_name, :second_player_name, :game_board

  def initialize(args)
    @first_player_sign = args[:first_sign]
    @second_player_sign = args[:second_sign]
    @first_player_name = args[:first_name]
    @second_player_name = args[:second_name]
    @game_board = args[:board]
  end

  def check
    return unless check_arr || check_left_moves

    true
  end

  private

  def check_left_moves
    return unless game_board.any? { |arr| arr.any?(Integer) } == false

    puts "\nIt's a draw!"
    true
  end

  def first_player_won
    "\nCongratulations! #{first_player_name} won the game!"
  end

  def second_player_won
    "\nCongratulations! #{second_player_name} won the game!"
  end

  def first_column
    [].push(board_for_check[0][0], board_for_check[1][0], board_for_check[2][0])
  end

  def second_column
    [].push(board_for_check[0][1], board_for_check[1][1], board_for_check[2][1])
  end

  def third_column
    [].push(board_for_check[0][2], board_for_check[1][2], board_for_check[2][2])
  end

  def left_diagonal
    [].push(board_for_check[0][0], board_for_check[1][1], board_for_check[2][2])
  end

  def right_diagonal
    [].push(board_for_check[0][2], board_for_check[1][1], board_for_check[2][0])
  end

  def board_for_check
    game_board.map do |arr|
      arr.reject { |element| element == ' | ' }
    end
  end

  def check_arr
    arrays = board_for_check.push(first_column, second_column, third_column, left_diagonal, right_diagonal)
    arrays.any? do |arr|
      if arr.all?(first_player_sign)
        puts first_player_won
        return true
      elsif arr.all?(second_player_sign)
        puts second_player_won
        return true
      end
    end
  end
end

# Helper for the class WinnerCheck
module WinnerCheckWrapper
  def self.winner_check(args)
    check = WinnerCheck.new({
                              first_sign: args[:first_sign],
                              second_sign: args[:second_sign],
                              board: args[:board],
                              first_name: args[:first_name],
                              second_name: args[:second_name]
                            }).check
    return true if check
  end
end
