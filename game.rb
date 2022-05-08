# frozen_string_literal: true

class Game
  attr_accessor :ante, :deck, :player, :dealer, :finish

  def initialize(name)
    @ante = 0
    @player = Player.new(name)
    @dealer = Dealer.new
    @deck = Deck.new
    @deck.generate_card
    @finish = false
  end

  def start_game
    2.times do
      add_cards(@dealer)
      add_cards(@player)
    end

    @player.wager_money
    @dealer.wager_money
    @ante = 20
  end

  def new_game
    @finish = false
    @deck.cards.clear
    @deck.generate_card
    @dealer.rand_cards.clear
    @player.rand_cards.clear
    @dealer.poits = 0
    @player.poits = 0
  end

  # после рандомного перебирания карта удаляется из колоды, а надо было, а надо было?

  def add_cards(choice, number = 1)
    random = @deck.cards.sample(number)
    choice.add_cards(random)
    @deck.cards.each_with_index do |card, index|
      random.select do |rand_card|
        @deck.delete_card(index) if card.rank_suit == rand_card.rank_suit
      end
    end
  end
end
