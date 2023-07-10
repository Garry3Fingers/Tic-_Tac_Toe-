# frozen_string_literal: true

# This class receives data from the user for the Player class
class DataForCreatingPlayers
  attr_accessor :first_player, :second_player

  def initialize
    @first_player = {}
    @second_player = {}
  end

  def players_data
    while second_player.empty?
      data = ask_data
      player = ''
      player = first_player if first_player.empty?
      player = second_player unless first_player.empty?
      player[:name] = data[:name]
      player[:sign] = data[:sign]
    end

    { first_player:, second_player: }
  end

  private

  def ask_data
    puts ask_name

    name = user_input

    puts ask_sign

    sign = set_sign

    { name:, sign: }
  end

  def user_input
    gets.chomp
  end

  def ask_name
    if first_player.empty?
      'Enter the first player name'
    else
      'Enter the second player name'
    end
  end

  def ask_sign
    if first_player.empty?
      'Enter a letter for the first player\'s sign'
    else
      "Enter a letter for the second player\'s sign\n"\
      "It mustn't be #{first_player[:sign]}"
    end
  end

  def set_sign
    sign = user_input
    if first_player[:sign] == sign || sign.match?(/[[:digit:]]/)\
      || sign.length > 1 || sign.match?(/\W+/)
      raise InvalidInput, 'Invalid input. Use a different letter!'
    end
  rescue InvalidInput => e
    puts e
    retry
  else
    sign
  end
end

class InvalidInput < StandardError; end
