# frozen_string_literal: true

# Class shows state of game board
class Board
  attr_accessor :board

  def initialize
    @board = [[1, ' | ', 2, ' | ', 3], [4, ' | ', 5, ' | ', 6], [7, ' | ', 8, ' | ', 9]]
  end

  def to_s
    " #{board.first.join}\n #{board[1].join}\n #{board.last.join}"
  end

  def board_for_check
    board.map do |arr|
      arr.reject { |element| element == ' | ' }
    end
  end

  def process_player_move(player_sign, move)
    board.map! do |arr|
      index = arr.find_index(move)
      arr[index] = player_sign if arr.include?(move)
      arr
    end
    puts self
  end
end
