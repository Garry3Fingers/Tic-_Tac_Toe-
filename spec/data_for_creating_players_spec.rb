# frozen_string_literal: true

require_relative '../lib/data_for_creating_players'

describe DataForCreatingPlayers do
  subject(:data) { described_class.new }

  describe '#players_data' do
    before do
      allow(data).to receive(:gets).and_return('Vlad', 'V', 'Alina', 'A')
      allow(data).to receive(:puts)
    end

    it 'returns hash with data' do
      expect(data.players_data).to eq({ first_player: { name: 'Vlad', sign: 'V' },\
                                        second_player: { name: 'Alina', sign: 'A' } })
    end
  end
end
