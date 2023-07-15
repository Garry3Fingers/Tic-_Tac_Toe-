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
      break if winner_check

      second_player_move
      break if winner_check
    end
  end

  private

  def first_player_move
    puts "#{player_name { first_player_name }} make your move!"
    player_make_move(player_sign { first_player_sign }, player_input { second_player_input })
  end

  def second_player_move
    puts "#{player_name { second_player_name }} make your move!"
    player_make_move(player_sign { second_player_sign }, player_input { second_player_input })
  end

  def player_make_move(player_sign, player_input)
    game_board.process_player_move(player_sign, player_input)
  end

  def player_input
    yield
  end

  def first_player_input
    first_player.player_input(game_board)
  end

  def second_player_input
    second_player.player_input(game_board)
  end

  def player_name
    yield
  end

  def first_player_name
    first_player.name
  end

  def second_player_name
    second_player.name
  end

  def player_sign
    yield
  end

  def first_player_sign
    first_player.sign
  end

  def second_player_sign
    second_player.sign
  end

  def winner_check
    WinnerCheckWrapper.winner_check(args)
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
