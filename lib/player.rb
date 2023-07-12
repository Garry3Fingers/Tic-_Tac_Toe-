# frozen_string_literal: true

# Class shows state of player
class Player
  attr_reader :name, :sign

  def initialize(name, sign)
    @name = name
    @sign = sign
  end

  def to_s
    "Player: #{name}, sign: #{sign}."
  end

  def make_move(board)
    input = gets.chomp
    unless input.match?(/[[:digit:]]/) && board.board.any? { |arr| arr.include?(input.to_i) } == true
      raise InvalidInput, 'Invalid input. Use a different number!'
    end
  rescue InvalidInput => e
    puts e
    retry
  else
    input.to_i
  end
end

class InvalidInput < StandardError; end
