# frozen_string_literal: true

class Deck
  attr_accessor :cards, :suit

  CARDS = { '2♠' => 2, '3♠' => 3, '4♠' => 4, '5♠' => 5, '6♠' => 6, '7♠' => 7, '8♠' => 8, '9♠' => 9, '10♠' => 10, 'J♠' => 10, 'Q♠' => 10,
            'K♠' => 10, 'A♠' => 11, '2♥' => 2, '3♥' => 3, '4♥' => 4, '5♥' => 5, '6♥' => 6, '7♥' => 7, '8♥' => 8, '9♥' => 9, '10♥' => 10, 'J♥' => 10,
            'Q♥' => 10, 'K♥' => 10, 'A♥' => 11, '2♣' => 2, '3♣' => 3, '4♣' => 4, '5♣' => 5, '6♣' => 6, '7♣' => 7, '8♣' => 8, '9♣' => 9, '10♣' => 10,
            'J♣' => 10, 'Q♣' => 10, 'K♣' => 10, 'A♣' => 11, '2♦' => 2, '3♦' => 3, '4♦' => 4, '5♦' => 5, '6♦' => 6, '7♦' => 7, '8♦' => 8, '9♦' => 9,
            '10♦' => 10, 'J♦' => 10, 'Q♦' => 10, 'K♦' => 10, 'A♦' => 11 }.freeze

  def initialize
    @cards = []
  end

  def generate_card
    CARDS.each do |suit, value|
      @cards << Card.new(suit, value)
    end
  end

  def delete_card(card)
    @cards.delete_at(card)
  end
end
