# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:game_board) { described_class.new }

  describe '#process_player_move' do
    it 'updates @board' do
      player_sign = 'V'
      move = 1
      game_board.process_player_move(player_sign, move)
      expect(game_board.board[0][0]).to eq('V')
    end
  end
end
