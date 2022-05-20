# frozen_string_literal: true

class Game
  attr_reader :ante, :deck, :player, :dealer, :finish, :bank

  def initialize(name)
    @bank = Bank.new
    @player = Player.new(name)
    @dealer = Dealer.new
    @deck = Deck.new
    @deck.generate_card
  end

  def start_game
    2.times do
      add_card(@dealer)
      add_card(@player)
    end

    @player.wager_money
    @dealer.wager_money
    @bank.add_money
  end

  def new_game
    @deck.cards.clear
    @deck.generate_card
    @dealer.cards.clear
    @player.cards.clear
    @dealer.points = 0
    @player.points = 0
  end

  def add_card(player)
    player.add_card(@deck.cards.sample)
  end

  def count_results
    if (@player.points == @dealer.points) || (score_limit?(@player) && score_limit?(@dealer))
      :nil
    elsif score_limit?(@player)
      @dealer
    elsif score_limit?(@dealer)
      @player
    else
      [@player, @dealer].max_by(&:points)
    end
  end

  def score_limit?(player)
    player.points > 21
  end

  def awarding_prize(player)
    if player == :nil
      @player.return_money
      @dealer.return_money
    else
      player.twenty_money
    end
    @bank.refund
  end

  def automatic_check
    count_results if @player.cards.size == 3 && @dealer.cards.size == 3
  end

  def balance_check
    if @dealer.purse.zero?
      :dealer_purse_zero
    elsif @player.purse.zero?
      :player_purse_zero
    end
  end

  def add_one_card_player
    if @player.cards.size == 3
      :player_three_cards
    else
      add_card(@player)
      :dealer_move
    end
  end

  def add_one_card_dealer
    if @dealer.cards.size == 3
      :dealer_three_cards
    elsif @dealer.points >= 17
      :dealer_skip_move
    else
      add_card(@dealer)
      :dealer_add_one_card
    end
  end
end
