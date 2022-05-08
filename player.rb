# frozen_string_literal: true

class Player
  attr_accessor :name, :bank, :rand_cards, :poits, :purse

  ACES = ['A♦', 'A♣', 'A♠', 'A♥'].freeze

  def initialize(name)
    @name = name
    @purse = 100
    @rand_cards = []
    @poits = 0
  end

  def add_cards(card)
    @rand_cards << card
    change_ace_value
    count_points
  end

  def change_ace_value
    @rand_cards.flatten.each do |card|
      ACES.select do |ace|
        card.value = 1 if @poits > 10 && card.rank_suit.include?(ace)
      end
    end
  end

  def count_points
    @poits = 0
    @rand_cards.flatten.each { |card| @poits += card.value }
  end

  def return_money
    @purse += 10
  end

  def wager_money
    @purse -= 10
  end
end
