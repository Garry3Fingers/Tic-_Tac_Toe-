class Board
  attr_accessor :board

  def initialize
    @board = [[1, '|', 2, '|', 3], [4, '|', 5, '|', 6], [7, '|', 8, '|', 9]]
  end

  def to_s
    "#{board.first.join}\n#{board[1].join}\n#{board.last.join}"
  end
end

class Players

end

class PlayerOne < Players

end

class PlayerTwo < Players

end

board = Board.new
puts board
