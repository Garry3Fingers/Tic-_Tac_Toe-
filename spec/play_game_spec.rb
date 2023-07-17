# frozen_string_literal: true

require_relative '../lib/play_game'
require_relative '../lib/winner_check'

describe PlayGame do
  let(:first_player) { double('player', name: 'Vlad', sign: 'V') }
  let(:second_player) { double('player', name: 'Anastasia', sign: 'A') }
  let(:board) { double('board') }
  subject(:game) { described_class.new({ first_player:, second_player:, board: }) }

  describe '#play_game' do
    context 'when player moves' do
      before do
        allow(board).to receive(:process_player_move)
        allow(board).to receive(:board)
        allow(first_player).to receive(:player_input)
        allow(second_player).to receive(:player_input)
        allow(game).to receive(:puts)
        allow(WinnerCheckWrapper).to receive(:winner_check).and_return(true)
      end

      it 'sends process_player_move' do
        expect(board).to receive(:process_player_move)
        game.play_game
      end

      it 'stops after #winner_check returns true' do
        expect(board).to receive(:process_player_move).once
        game.play_game
      end
    end
  end
end
