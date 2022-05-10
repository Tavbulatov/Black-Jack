# frozen_string_literal: true

class Interface
  attr_reader :game

  def initialize(name)
    @game = name
  end

  def start_game
    @game.start_game
    puts '        _______NEW GAME______'
    puts '        + ## ХОДИТ ИГРОК ## +'
    puts '|===================================|'
    show_cards_and_bank
    loop do
      add_cards_player_and_dealer
    end
  end

  private

  def add_cards_player_and_dealer
    message(@game.automatic_check)
    puts
    puts 'ВЫБЕРИТЕ ХОД: 1-Пропустить, 2-Добавить карту, 3-Открыть карты'
    case gets.chomp.upcase.to_s
    when '1'
      message(@game.add_one_card_dealer)
      show_cards_and_bank
    when '2'
      message(@game.add_one_card_player)
      show_cards_and_bank
    when '3'
      result = @game.count_results
      message(result)
    when 'Y'
      message(@game.balance_check)
      @game.new_game
      start_game
    when 'N'
      exit
    end
  end

  def message(command)
    case command
    when :player_three_cards
      puts '+ ## У ИГРОКА ТРИ КАРТЫ ## +'
    when :dealer_move
      puts '+ ## ХОД ПЕРЕХОДИТ ДИЛЛЕРУ ## +'
    when :dealer_three_cards
      puts '+ ## У ДИЛЛЕРА ТРИ КАРТЫ ## +'
    when :dealer_skip_move
      puts '+ ## ДИЛЛЕР ПРОПУСТИЛ ХОД ## +'
    when :dealer_add_one_card
      puts '+ ## ДИЛЛЕР ВЗЯЛ ОДНУ КАРТУ ## +'
    when :three_cards
      result = @game.count_results
      message(result)
    when :draw
      puts '___________________________________________________'
      puts '           + ## ПОДВЕДЕНИЕ ИТОГОВ ## +'
      puts '|=================================================|'
      puts '___________________________________________________'
      puts '           |-----+ ## НИЧЬЯ ## +-----|'
      puts '___________________________________________________'
      open_cards
    when :player_win
      puts '___________________________________________________'
      puts '            + ## ПОДВЕДЕНИЕ ИТОГОВ ## +'
      puts '|=================================================|'
      puts '__________________________________________________'
      puts '|       |-----+ ## ИГРОК ВЫИГРАЛ ## +-----|       |'
      puts '|_________________________________________________|'
      open_cards
    when :dealer_win
      puts '___________________________________________________'
      puts '            + ## ПОДВЕДЕНИЕ ИТОГОВ ## +'
      puts '|=================================================|'
      puts '___________________________________________________'
      puts '|       |----+ ## ДИЛЛЕР ВЫИГРАЛ ## +-----|       |'
      puts '|_________________________________________________|'
      open_cards
    when :dealer_purse_zero
      puts '+ ## У ДИЛЛЕРА ЗАКОНЧИЛИСЬ ДЕНЬГИ ## +'
      exit
    when :player_purse_zero
      puts '+ ## У ИГРОКА ЗАКОНЧИЛИСЬ ДЕНЬГИ ## +'
      exit
    end
  end

  def dealer_open_cards
    puts "КАРТЫ ДИЛЛЕРА | ОЧКИ: #{dealer_poits} | БАНК: #{@game.dealer.purse}"
    @game.dealer.rand_cards.flatten.each { |card| print card.rank_suit }
    puts
  end

  def dealer_cards_poits
    puts "КАРТЫ ДИЛЛЕРА | ОЧКИ: #{dealer_poits} | БАНК: #{@game.dealer.purse}"
    puts '*' * dealer_cards_size
    puts
  end

  def player_cards_poits
    puts "КАРТЫ ИГРОКА  | ОЧКИ: #{player_poits} | БАНК: #{@game.player.purse}"
    @game.player.rand_cards.flatten.each { |card| print card.rank_suit }
    puts
  end

  def message_new_game
    puts '_________________________________________________'
    puts '+ ## ЧТОБЫ СЫГРАТЬ ЕЩЕ ИЛИ ВЫЙТИ НАЖМИТЕ Y/N ## +'
  end

  def dealer_poits
    @game.dealer.poits
  end

  def player_poits
    @game.player.poits
  end

  def player_cards_size
    @game.player.rand_cards.flatten.size
  end

  def dealer_cards_size
    @game.dealer.rand_cards.flatten.size
  end

  def open_cards
    puts "$$---БАНК #{@game.bank.bank}---$$"
    player_cards_poits
    dealer_open_cards
    message_new_game
  end

  def show_cards_and_bank
    puts "$$---БАНК #{@game.bank.bank}---$$"
    player_cards_poits
    dealer_cards_poits
  end
end
