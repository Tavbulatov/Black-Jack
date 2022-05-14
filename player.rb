# frozen_string_literal: true

class Player
  attr_reader :name, :bank, :cards, :purse
  attr_accessor :poits

  def initialize(name = 'ВИТАЛИК КАТОЛИК')
    @name = name.upcase
    @purse = 100
    @cards = []
    @poits = 0
  end

  def add_card(card)
    @cards << card
    change_ace_value
    count_points
  end

  def change_ace_value
    @cards.flatten.each_with_index do |card, index|
      if card.rank.include?('A') && @poits > 10 && index != 0 #так при взятии 2-го и 3-го туза
        card.value = 1                                         #он значение 1-го туза не поменяет.
      end
    end
  end

  def count_points
    @poits = 0
    @cards.flatten.each { |card| @poits += card.value }
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
