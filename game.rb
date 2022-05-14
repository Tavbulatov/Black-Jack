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
    dealer_poits = 0
    player_poits = 0
  end

  def add_card(person)
    person.add_card(@deck.cards.sample)
  end

  def count_results
    if dealer_poits > 21
      @player
    elsif dealer_poits == player_poits
      :nil
    elsif player_poits > dealer_poits
      @player
    elsif dealer_poits > player_poits && dealer_poits <= 21 #Оба превысить не могут,может только диллер и это станет понятно после
      @dealer                                                     #после вскрытия карт
    end                                                          #а когда игрок превысит 21, то automatic_check подведет итоги
  end

  def awarding_prize(player) #вручение приза
    case player
    when @player
      @bank.refund
      @player.twenty_money
    when @dealer
      @bank.refund
      @dealer.twenty_money
    when :nil
      @bank.refund
      @player.return_money
      @dealer.return_money
    end
  end

  def automatic_check    # чекает игру после взятия карты
    if player_poits > 21 # автоматом подводит итоги
      @dealer
    elsif player_cards_size == 3 && dealer_cards_size == 3
      count_results
    end
  end

  def balance_check
    if @dealer.purse.zero?
      return :dealer_purse_zero
    elsif @player.purse.zero?
      return :player_purse_zero
    end
  end

  def add_one_card_player
    if player_cards_size == 3
      return :player_three_cards
    else
      add_card(@player)
      return :dealer_move
    end
  end

  def add_one_card_dealer
    if dealer_cards_size == 3
      return :dealer_three_cards
    elsif  dealer_poits >= 17
      return :dealer_skip_move
    else
      add_card(@dealer)
      return :dealer_add_one_card
    end
  end

  def dealer_poits
    @dealer.poits
  end

  def player_poits
    @player.poits
  end

  def player_cards_size
    @player.cards.flatten.size
  end

  def dealer_cards_size
    @dealer.cards.flatten.size
  end
end
