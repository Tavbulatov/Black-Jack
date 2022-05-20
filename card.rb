# frozen_string_literal: true

class Card
  attr_accessor :rank, :suit, :value

  RANK_VALUE = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9,
                 '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => 11 }.freeze

  SUIT = %w[♠ ♥ ♣ ♦].freeze

  def initialize(rank, suit, value)
    @rank = rank
    @suit = suit
    @value = value
  end

  def ace?
    @rank == 'A'
  end
end
