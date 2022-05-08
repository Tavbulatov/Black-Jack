# frozen_string_literal: true

class Card
  attr_accessor :rank_suit, :value

  def initialize(rank_suit, value)
    @rank_suit = rank_suit
    @value = value
  end
end
