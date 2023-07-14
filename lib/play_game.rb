# frozen_string_literal: true

# This class implements the game flow
class PlayGame
  attr_reader :first_player, :second_player, :game_board

  def initialize(args)
    @first_player = args[:first_player]
    @second_player = args[:second_player]
    @game_board = args[:board]
  end

  def play_game
    puts game_board
    loop do
      first_player_move
      break if WinnerCheckWrapper.winner_check(args)

      second_player_move
      break if WinnerCheckWrapper.winner_check(args)
    end
  end

  private

  def first_player_move
    puts "#{first_player.name} make your move!"
    game_board.process_player_move(first_player.sign, first_player.make_move(game_board))
  end

  def second_player_move
    puts "#{second_player.name} make your move!"
    game_board.process_player_move(second_player.sign, second_player.make_move(game_board))
  end

  def args
    {
      board: game_board,
      first_name: first_player.name,
      second_name: second_player.name,
      first_sign: first_player.sign,
      second_sign: second_player.sign
    }
  end
end
