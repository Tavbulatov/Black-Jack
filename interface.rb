# frozen_string_literal: true

class Interface
  attr_accessor :game

  def initialize(name)
    @game = name
  end

  def start_game
    @game.start_game
    puts '+ ## ХОДИТ ИГРОК ## +'
    loop do
      add_cards_player_and_dealer
    end
  end

  def add_cards_player_and_dealer
    automatic_check
    show_cards
    message if @game.finish == true
    puts
    puts 'ВЫБЕРИТЕ ХОД: 1-Пропустить, 2-Добавить карту, 3-Открыть карты'
    case gets.chomp.upcase.to_s
    when '1'
      add_one_card_dealer
    when '2'
      add_one_card_player
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

  def add_one_card_player
    if @game.player.rand_cards.flatten.size == 3
      puts 'У ИГРОКА УЖЕ ЕСТЬ ТРИ КАРТЫ'
    else
      @game.add_cards(@game.player)
      puts '+ ## ХОД ПЕРЕХОДИТ ДИЛЛЕРУ ## +' if @game.player.poits < 21
    end
  end

  def add_one_card_dealer
    if @game.dealer.rand_cards.flatten.size == 3
      puts 'У ДИЛЛЕРА УЖЕ ЕСТЬ ТРИ КАРТЫ'
    elsif @game.dealer.poits > 17
      puts '+ ## ДИЛЛЕР ПРОПУСТИЛ ХОД ## +'
      puts '+ ## ХОД ПЕРЕХОДИТ К ИГРОКУ ## +'
    else
      @game.add_cards(@game.dealer)
      puts '+ ## ДИЛЛЕР ВЗЯЛ ОДНУ КАРТУ ## +'
      puts
      puts '+ ## ХОД ПЕРЕХОДИТ К ИГРОКУ ## +'
    end
  end


  def automatic_check
    if @game.dealer.poits > 21
      puts '+ ## ДИЛЛЕР ПРОИГРАЛ ## +'
      @ante = 0
      @game.player.purse += 20
      message
    elsif @game.player.poits > 21
      puts '+ ## ИГРОК ПРОИГРАЛ ## +'
      @ante = 0
      @game.dealer.purse += 20
      message
    elsif @game.player.rand_cards.flatten.size == 3 && @game.dealer.rand_cards.flatten.size == 3
      count_results
      message
    end
  end

  def dealer_poits
    @game.dealer.poits
  end

  def player_poits
    @game.player.poits
  end

  def count_results
    @game.ante = 0
    puts '+ ## ПОДВЕДЕНИЕ ИТОГОВ ## +'
    result = @game.player.poits - @game.dealer.poits

    if dealer_poits == player_poits
      puts '+ ## НИЧЬЯ ## +'
      @game.player.return_money
      @game.dealer.return_money
    elsif player_poits > dealer_poits && player_poits <= 21
      @game.player.purse += 20
      puts '========================'
      puts '+ ## ИГРОК ВЫИГРАЛ ## +'
    elsif dealer_poits >
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
