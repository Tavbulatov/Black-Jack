# frozen_string_literal: true

class Controller
  attr_accessor :ante, :deck, :player, :dealer

  def initialize(name)
    @ante = 0
    @player = Player.new(name)
    @dealer = Dealer.new
    @deck = Deck.new
    @deck.generate_card
  end

  def add_cards_player_and_dealer
    puts 'ВЫБЕРИТЕ ХОД: 1-Пропустить, 2-Добавить карту, 3-Открыть карты'

    case gets.chomp.upcase.to_s
    when '1'
      add_cards(@dealer, 1)
      show_cards
    when '2'
      add_cards(@player, 1)
      show_cards
    when '3'
      count_results
      show_secret_cards
    when 'Y'
      if @dealer.purse.zero? || @player.purse.zero?
        puts '+ ## У ОДНОГО ИЗ ИГРОКОВ ЗАКОНЧИЛИСЬ ДЕНЬГИ ## +'
        exit
      else
        new_game
        start_game
      end
    when 'N'
      exit
    end
    automatic_check
  end

  def start_game
    add_cards(@dealer)
    add_cards(@player)
    @player.wager_money
    @dealer.wager_money
    @ante = 20
    show_cards
    add_cards_player_and_dealer
  end

  def new_game
    @deck.cards.clear
    @deck.generate_card
    @dealer.rand_cards.clear
    @player.rand_cards.clear
    @dealer.poits = 0
    @player.poits = 0
  end

  def automatic_check
    if @dealer.poits > 21
      puts '+ ## ДИЛЛЕР ПРОИГРАЛ ## +'
      @ante = 0
      @player.purse += 20
      show_secret_cards
    elsif @player.poits > 21
      puts '+ ## ИГРОК ПРОИГРАЛ ## +'
      @ante = 0
      @dealer.purse += 20
      show_secret_cards
    elsif @player.rand_cards.flatten.size == 3 && @dealer.rand_cards.flatten.size == 3
      count_results
      show_secret_cards
    end
  end

  def count_results
    @ante = 0
    puts '+ ## ПОДВЕДЕНИЕ ИТОГОВ ## +'
    result = @player.poits - @dealer.poits
    if result.zero?
      puts '+ ## НИЧЬЯ ## +'
      @player.return_money
      @dealer.return_money
    elsif result.positive?
      @player.purse += 20
      puts '========================'
      puts '+ ## ИГРОК ВЫИГРАЛ ## +'
    elsif result.negative?
      @dealer.purse += 20
      puts '========================'
      puts '+ ## ДИЛЛЕР ВЫИГРАЛ ## +'
    end
  end

  # после рандомного перебирания карта удаляется из колоды, а надо было, а надо было?

  def add_cards(choice, number = 2)
    random = @deck.cards.sample(number)
    choice.add_cards(random)
    @deck.cards.each_with_index do |card, index|
      random.select do |rand_card|
        @deck.delete_card(index) if card.suit == rand_card.suit
      end
    end
  end

  def show_cards
    @player.cards_hands
    puts '=-=-=-=-=-=-=-=-=-=-='
    @dealer.cards_hands
  end

  def show_secret_cards
    @player.cards_hands
    puts '=-=-=-=-=-=-=-=-=-=-='
    @dealer.open_cards
    puts '+ ## ХОТИТЕ СЫГРАТЬ ЕЩЕ? Y/N ## +'
  end
end
