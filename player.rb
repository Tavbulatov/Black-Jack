# frozen_string_literal: true

class Player
  attr_reader :name, :bank, :rand_cards, :purse
  attr_accessor :poits

  ACES = ['A♦', 'A♣', 'A♠', 'A♥'].freeze

  def initialize(name = 'ВИТАЛИК КАТОЛИК')
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

  def twenty_money
    @purse += 20
  end

  def wager_money
    @purse -= 10
  end
end
