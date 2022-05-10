# frozen_string_literal: true

class Game
  attr_reader :ante, :deck, :player, :dealer, :finish, :bank

  def initialize(name)
    @bank = Bank.new
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
    @bank.add_money
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

  def add_cards(choice, number = 1)
    random = @deck.cards.sample(number)
    choice.add_cards(random)
    @deck.cards.each_with_index do |card, index|
      random.select do |rand_card|
        @deck.delete_card(index) if card.rank_suit == rand_card.rank_suit
      end
    end
  end

  def count_results
    @bank.refund if @finish == false
    if dealer_poits == player_poits
      @player.return_money if @finish == false
      @dealer.return_money if @finish == false
      @finish = true
      return :draw
    elsif player_poits > dealer_poits && player_poits <= 21
      @player.twenty_money if @finish == false
      @finish = true
      return :player_win
    elsif dealer_poits > player_poits && dealer_poits <= 21
      @dealer.twenty_money if @finish == false
      @finish = true
      return :dealer_win
    end
  end

  def automatic_check
    if dealer_poits > 21
      @bank.refund if @finish == false
      @player.twenty_money if @finish == false
      @finish = true
      return :player_win
    elsif player_poits > 21
      @bank.refund if @finish == false
      @dealer.twenty_money if @finish == false
      @finish = true
      return :dealer_win
    elsif player_cards_size == 3 && dealer_cards_size == 3
      return :three_cards
    end
  end

  def balance_check
    if @dealer.purse.zero?
      return :dealer_purse_zero
      sleep(3)
      exit
    elsif @player.purse.zero?
      return :player_purse_zero
      sleep(3)
      exit
    end
  end

  def add_one_card_player
    if player_cards_size == 3
      return :player_three_cards
    else
      add_cards(@player)
      return :dealer_move if player_poits <= 21
    end
  end

  def add_one_card_dealer
    if dealer_cards_size == 3
      return :dealer_three_cards
    elsif  dealer_poits >= 17
      return :dealer_skip_move
    else
      add_cards(@dealer) if player_poits <= 21
      return :dealer_add_one_card if player_poits <= 21
    end
  end

  def dealer_poits
    @dealer.poits
  end

  def player_poits
    @player.poits
  end

  def player_cards_size
    @player.rand_cards.flatten.size
  end

  def dealer_cards_size
    @dealer.rand_cards.flatten.size
  end
end
