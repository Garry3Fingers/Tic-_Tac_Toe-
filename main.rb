# frozen_string_literal: true

require './lib/board'
require './lib/player'
require './lib/data_for_creating_players'
require './lib/play_game'

# This module is responsible for creating and running the game
module StartingGame
  def self.start_game
    data = DataForCreatingPlayers.new.players_data
    game = PlayGame.new({
                          board: Board.new,
                          first_player: Player.new(data[:first_player][:name], data[:first_player][:sign]),
                          second_player: Player.new(data[:second_player][:name], data[:second_player][:sign])
                        })
    game.play_game
    new_game
  end

  def self.new_game
    puts 'Do you start a new game?(yes or anything)'
    answer = gets.chomp
    return unless answer.downcase == 'yes'

    start_game
  end
end

StartingGame.start_game
