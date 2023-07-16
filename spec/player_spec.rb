# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new('Vlad', 'V') }

  describe '#player_input' do
    context 'when the input is valid' do
      before do
        valid_input = '1'
        allow(player).to receive(:gets).and_return(valid_input)
      end

      it 'returns number 1' do
        board = [[1], [2]]
        expect(player.player_input(board)).to eq(1)
      end

      it "doesn't get InvalidInput error" do
        board = [[1], [2]]
        expect(player).not_to receive(:puts).with(InvalidInput)
        player.player_input(board)
      end
    end

    context 'when the input is invalid, then valid' do
      before do
        invalid_input = 'd'
        valid_input = '2'
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'get InvalidInput error once' do
        board = [[1], [2]]
        expect(player).to receive(:puts).with(InvalidInput).once
        player.player_input(board)
      end
    end
  end
end
