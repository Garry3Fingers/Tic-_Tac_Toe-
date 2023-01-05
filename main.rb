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

  def process_player_move(player_sign, move)
    move_board.map! do |arr|
      index = arr.find_index(move)
      arr[index] = player_sign if arr.include?(move)
      arr
    end
    puts self
  end
end

class Player
  attr_reader :name, :sign

  def initialize(name, sign)
    @name = name
    @sign = sign
  end

  def to_s
    "Player: #{name}, sign: #{sign}."
  end

  def make_move
    input = gets.chomp
    unless input.match?(/[[:digit:]]/) && PlayGame::BOARD.move_board.any? { |arr| arr.include?(input.to_i) } == true
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

# This module implements game rounds
module PlayGame
  BOARD = Board.new

  def self.first_player_move
    puts "#{CreatePlayer::FIRST_PLAYER.name} make your move!"
    BOARD.process_player_move(CreatePlayer::FIRST_PLAYER.sign, CreatePlayer::FIRST_PLAYER.make_move)
  end

  def self.second_player_move
    puts "#{CreatePlayer::SECOND_PLAYER.name} make your move!"
    BOARD.process_player_move(CreatePlayer::SECOND_PLAYER.sign, CreatePlayer::SECOND_PLAYER.make_move)
  end

  def self.check_left_moves
    BOARD.move_board.any? { |arr| arr.any?(Integer) } == false
  end

  def self.play_game
    loop do
      PlayGame.first_player_move
      break if PlayGame.check_left_moves

      PlayGame.second_player_move
      break if PlayGame.check_left_moves
    end
    puts 'It\'s a draw!'
  end
end

# This module creates new players
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

  FIRST_PLAYER = CreatePlayer.create_player
  SECOND_PLAYER = CreatePlayer.create_player
end

puts  CreatePlayer::FIRST_PLAYER
puts  CreatePlayer::SECOND_PLAYER

puts PlayGame::BOARD

# puts  CreatePlayer::FIRST_PLAYER.sign
# puts  CreatePlayer::SECOND_PLAYER.sign
PlayGame.play_game
