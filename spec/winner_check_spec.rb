# frozen_string_literal: true

require_relative '../lib/winner_check'

describe WinnerCheck do
  describe '#check' do
    args = {
      first_sign: 'V',
      second_sign: 'N',
      board: [%w[V V V], [2, 2, 2], [3, 3, 3]],
      first_name: 'Vlad',
      second_name: 'Natasha'
    }
    subject(:winner) { described_class.new(args) }
    before do
      allow(winner).to receive(:puts)
    end

    it 'returns true' do
      expect(winner.check).to be(true)
    end

    it 'returns true when is there is no move left' do
      winner.instance_variable_set(:@game_board, [%w[V V N], %w[N V V], %w[V N N]])
      expect(winner.check).to be(true)
    end

    it "doesn't return true" do
      winner.instance_variable_set(:@game_board, [[1, 1, 1], [2, 2, 2], [3, 3, 3]])
      expect(winner.check).not_to be(true)
    end
  end
end

describe WinnerCheckWrapper do
  it 'returns true' do
    args = {
      first_sign: 'V',
      second_sign: 'N',
      board: [%w[V V V], [2, 2, 2], [3, 3, 3]],
      first_name: 'Vlad',
      second_name: 'Natasha'
    }
    expect(WinnerCheckWrapper.winner_check(args)).to be(true)
  end

  it "doesn't return true" do
    args = {
      first_sign: 'V',
      second_sign: 'N',
      board: [%w[V N V], [2, 2, 2], [3, 3, 3]],
      first_name: 'Vlad',
      second_name: 'Natasha'
    }

    expect(WinnerCheckWrapper.winner_check(args)).not_to be(true)
  end
end
