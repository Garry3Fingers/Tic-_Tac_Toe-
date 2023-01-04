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

module CreatePlayer
  def self.input
    gets.chomp
  end

  def self.set_sign
    sign = CreatePlayer.input
    if defined?(FIRST_PLAYER) == 'constant' && FIRST_PLAYER.sign == sign || sign.match?(/[[:digit:]]/)\
      || sign.length > 1 || sign.match?(/\W+/)
      raise InvalidInput, 'Invalid input. Use a different letter!'
    end
  rescue InvalidInput => e
    puts e
    retry
  else
    sign
  end

  def self.ask_name
    if defined?(FIRST_PLAYER) == 'constant'
      'Enter the second player name'
    else
      'Enter the first player name'
    end
  end

  def self.ask_sign
    if defined?(FIRST_PLAYER) == 'constant'
      "Enter a letter for the second player\'s sign\n"\
      "It mustn't be #{FIRST_PLAYER.sign}"
    else
      'Enter a letter for the first player\'s sign'
    end
  end

  def self.create_player
    puts CreatePlayer.ask_name

    name = CreatePlayer.input

    puts CreatePlayer.ask_sign

    sign = CreatePlayer.set_sign

    Player.new(name, sign)
  end
end

puts FIRST_PLAYER = CreatePlayer.create_player
puts SECOND_PLAYER = CreatePlayer.create_player

board = Board.new
puts board
