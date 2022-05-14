# frozen_string_literal: true

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def generate_card
    Card::SUIT.each do |suit|
      @cards.shuffle!
      Card::RANK_VALUE.each do |rank, value|
        @cards << Card.new(rank, suit, value)
      end
    end
  end
end
