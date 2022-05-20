# frozen_string_literal: true

class Player
  attr_reader :name, :bank, :cards, :purse
  attr_accessor :points

  def initialize(name = 'ВИТАЛИК КАТОЛИК')
    @name = name.upcase
    @purse = 100
    @cards = []
    @points = 0
  end

  def add_card(card)
    @cards << card
    count_points
  end

  def count_points
    @points = @cards.sum(&:value)
    @cards.select(&:ace?).each do |_card|
      @points -= 10 if @points > 21
    end
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
