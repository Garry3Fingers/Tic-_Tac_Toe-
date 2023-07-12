# frozen_string_literal: true

# Class shows state of game board
class Board
  attr_reader :board
  attr_accessor :move_board

  def initialize
    @board = [[1, ' | ', 2, ' | ', 3], [4, ' | ', 5, ' | ', 6], [7, ' | ', 8, ' | ', 9]]
    @move_board = board.map(&:clone)
  end

  def to_s
    " #{move_board.first.join}\n #{move_board[1].join}\n #{move_board.last.join}"
  end

  def board_for_check
    move_board.map do |arr|
      arr.reject { |element| element == ' | ' }
    end
  end

  def process_player_move(player_sign, move)
    move_board.map! do |arr|
      index = arr.find_index(move)
      arr[index] = player_sign if arr.include?(move)
      arr
    end
    puts self
  end
end
