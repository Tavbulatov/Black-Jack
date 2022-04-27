# frozen_string_literal: true

class Player < Controller
  attr_accessor :name, :bank, :rand_cards, :poits

  def initialize(name)
    @name = name
    @bank = 100
    @rand_cards = []
    @poits = 0
  end

  def random_cards(number = 2)
    if @rand_cards.size < 2
    @rand_cards << CARDS.keys.sample(number)
    @poits = 0
    @rand_cards.flatten.each do |card|
      @poits += CARDS[card]
    end
    else
      puts 'БОЛЬШЕ НЕЛЬЗЯ!'
    end
  end

  def cards_hands
    @rand_cards.flatten.each { |card| print card }
    puts
    puts "ОЧКИ: #{@poits}"
  end

  def return_money
    @bank += 10
  end

  def wager_money
    @bank -= 10
  end
end
