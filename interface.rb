# frozen_string_literal: true

class Interface
  attr_accessor :game

  def initialize(name)
    @game = name
  end

  def start_game
    @game.start_game
    loop do
      add_cards_player_and_dealer
    end
  end

  def add_cards_player_and_dealer
    show_cards
    automatic_check
    message if @game.finish == true
    puts
    puts 'ВЫБЕРИТЕ ХОД: 1-Пропустить, 2-Добавить карту, 3-Открыть карты'
    case gets.chomp.upcase.to_s
    when '1'
      @game.add_cards(@game.dealer)
    when '2'
      @game.add_cards(@game.player)
    when '3'
      @game.finish = true
      count_results
    when 'Y'
      balance_check
      @game.new_game
      @game.start_game
    when 'N'
      exit
    end
  end

  def automatic_check
    if @game.dealer.poits > 21
      puts '+ ## ДИЛЛЕР ПРОИГРАЛ ## +'
      @ante = 0
      @game.player.purse += 20
      show_cards
    elsif @game.player.poits > 21
      puts '+ ## ИГРОК ПРОИГРАЛ ## +'
      @ante = 0
      @game.dealer.purse += 20
      show_cards
    elsif @game.player.rand_cards.flatten.size == 3 && @game.dealer.rand_cards.flatten.size == 3
      count_results
      show_cards
    end
  end

  def count_results
    @game.ante = 0
    puts '+ ## ПОДВЕДЕНИЕ ИТОГОВ ## +'
    result = @game.player.poits - @game.dealer.poits

    if result.zero?
      puts '+ ## НИЧЬЯ ## +'
      @game.player.return_money
      @game.dealer.return_money
    elsif result.positive?
      @game.player.purse += 20
      puts '========================'
      puts '+ ## ИГРОК ВЫИГРАЛ ## +'
    elsif result.negative?
      @game.dealer.purse += 20
      puts '========================'
      puts '+ ## ДИЛЛЕР ВЫИГРАЛ ## +'
    end
  end

  def dealer_cards_poits
    puts "КАРТЫ ДИЛЛЕРА | ОЧКИ: #{@game.dealer.poits} | БАНК: #{@game.dealer.purse}"
    puts '*' * @game.dealer.rand_cards.flatten.size if @game.finish == false
    @game.dealer.rand_cards.flatten.each { |card| print card.rank_suit } if @game.finish == true
    puts
  end

  def player_cards_poits
    puts "КАРТЫ ИГРОКА  | ОЧКИ: #{@game.player.poits} | БАНК: #{@game.player.purse}"
    @game.player.rand_cards.flatten.each { |card| print card.rank_suit }
    puts
  end

  def message
    puts '+ ## ЧТОБЫ СЫГРАТЬ ЕЩЕ ИЛИ ВЫЙТИ НАЖМИТЕ Y/N ## +'
  end

  def balance_check
    if @game.dealer.purse.zero?
      puts '+ ## У ДИЛЛЕРА ЗАКОНЧИЛИСЬ ДЕНЬГИ ## +'
      exit
    elsif @game.player.purse.zero?
      puts '+ ## У ИГРОКА ЗАКОНЧИЛИСЬ ДЕНЬГИ ## +'
      exit
    end
  end

  def show_cards
    player_cards_poits
    dealer_cards_poits
  end
end
