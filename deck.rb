# frozen_string_literal: true

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def generate_card
    Card::SUIT.each do |suit|
      Card::RANK_VALUE.each do |rank, value|
        @cards << Card.new(rank + suit, value)
        @cards.shuffle!
      end
    end
  end

  def delete_card(card)
    @cards.delete_at(card)
  end
end
