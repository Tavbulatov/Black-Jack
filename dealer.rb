# frozen_string_literal: true

class Dealer < Player
  attr_accessor :poits

  def initialize
    @bank = 100
    @rand_cards = []
    @poits = 0
  end

  def open_cards
    puts 'КАРТЫ ДИЛЛЕРА'
    @rand_cards.flatten.each { |card| print card }
    puts
    puts "ОЧКИ: #{@poits}"
  end

  def cards_hands
    puts 'КАРТЫ ДИЛЛЕРА'
    puts '*' * @rand_cards.flatten.size
    puts "ОЧКИ: #{@poits}"
  end
end
