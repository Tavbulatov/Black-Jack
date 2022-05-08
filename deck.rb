# frozen_string_literal: true

class Deck
  attr_accessor :cards

  RANK_VALUE = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9,
                 '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => 11 }.freeze

  SUIT = %w[♠ ♥ ♣ ♦].freeze

  def initialize
    @cards = []
  end

  # я думаю так будет проще и мало кода (хотя бы на пару строчек меньше) писать придется чтобы показать карту и значение карты  нежели отдельно suit и rank, а?
  def generate_card
    SUIT.each do |suit|
      RANK_VALUE.each do |rank, value|
        @cards << Card.new(rank + suit, value)
        @cards.shuffle!
      end
    end
  end

  def delete_card(card)
    @cards.delete_at(card)
  end
end
