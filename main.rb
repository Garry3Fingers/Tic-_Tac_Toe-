class Board
  attr_accessor :board

  def initialize
    @board = [[1, '|', 2, '|', 3], [4, '|', 5, '|', 6], [7, '|', 8, '|', 9]]
  end

  def to_s
    "#{board.first.join}\n#{board[1].join}\n#{board.last.join}"
  end
end

class Player
  attr_accessor :name, :sign

  def initialize(name, sign)
    @name = name
    @sign = sign
  end

  def to_s
    "name: #{name} sign: #{sign}"
  end
end

class InvalidInput < StandardError; end

module Game
  def self.input
    gets.chomp
  end

  def self.create_player
    if defined?(FIRST_PLAYER) == 'constant'
      puts 'Enter the second player name'
    else
      puts 'Enter the first player name'
    end

    name = Game.input

    if defined?(FIRST_PLAYER) == 'constant'
      puts "Enter a letter for the second player\'s sign\n"\
      "It mustn't be #{FIRST_PLAYER.sign}"
    else
      puts 'Enter a letter for the first player\'s sign'
    end

    loop do
      begin
        sign = Game.input

        if defined?(FIRST_PLAYER) == 'constant' && FIRST_PLAYER.sign == sign || sign.match?(/[[:digit:]]/)\
          || sign.length > 1
          raise InvalidInput, 'Invalid input. Use a different letter!'
        end
      rescue InvalidInput => e
        puts e
        retry
      else
        return Player.new(name, sign)
      end
    end
  end
end

puts FIRST_PLAYER = Game.create_player
puts SECOND_PLAYER = Game.create_player

board = Board.new
puts board
