# frozen_string_literal: true

class Interface
  attr_reader :game

  def initialize(name)
    @game = Game.new(name)
  end

  def start_game
    @game.start_game
    puts '        _______NEW GAME______'
    puts '        + ## ХОДИТ ИГРОК ## +'
    puts '|===================================|'
    show_cards_bank_menu
    add_card_player_and_dealer
  end

  private

  def add_card_player_and_dealer
    message_result(@game.automatic_check)

    case gets.chomp.to_i
    when 1
      message(@game.add_one_card_dealer)
      show_cards_bank_menu
      add_card_player_and_dealer
    when 2
      message(@game.add_one_card_player)
      message(@game.add_one_card_dealer)
      show_cards_bank_menu
      add_card_player_and_dealer
    when 3
      message_result(@game.count_results)
    end
  end

  def message_result(command)
    case command
    when :nil
      puts '___________________________________________________'
      puts '           + ## ПОДВЕДЕНИЕ ИТОГОВ ## +'
      puts '|=================================================|'
      puts '___________________________________________________'
      puts '           |-----+ ## НИЧЬЯ ## +-----|'
      puts '___________________________________________________'
      @game.awarding_prize(command)
      open_cards
    when @game.player
      puts '___________________________________________________'
      puts '            + ## ПОДВЕДЕНИЕ ИТОГОВ ## +'
      puts '|=================================================|'
      puts '__________________________________________________'
      puts '|       |-----+ ## ИГРОК ВЫИГРАЛ ## +-----|       |'
      puts '|_________________________________________________|'
      @game.awarding_prize(command)
      open_cards
    when @game.dealer
      puts '___________________________________________________'
      puts '            + ## ПОДВЕДЕНИЕ ИТОГОВ ## +'
      puts '|=================================================|'
      puts '___________________________________________________'
      puts '|       |----+ ## ДИЛЛЕР ВЫИГРАЛ ## +-----|       |'
      puts '|_________________________________________________|'
      @game.awarding_prize(command)
      open_cards
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
    when :dealer_purse_zero
      puts '+ ## У ДИЛЛЕРА ЗАКОНЧИЛИСЬ ДЕНЬГИ ## +'
      exit
    when :player_purse_zero
      puts '+ ## У ИГРОКА ЗАКОНЧИЛИСЬ ДЕНЬГИ ## +'
      exit
    end
  end

  def dealer_open_cards
    puts "КАРТЫ ДИЛЛЕРА | ОЧКИ: #{@game.dealer.points} | БАНК: #{@game.dealer.purse}"
    @game.dealer.cards.each { |card| print card.rank + card.suit }
    puts
  end

  def dealer_cards_points
    puts "КАРТЫ ДИЛЛЕРА | ОЧКИ: ## | БАНК: #{@game.dealer.purse}"
    puts '*' * @game.dealer.cards.size
    puts
  end

  def player_cards_points
    puts "КАРТЫ #{@game.player.name} | ОЧКИ: #{@game.player.points} | БАНК: #{@game.player.purse}"
    @game.player.cards.each { |card| print card.rank + card.suit  }
    puts
  end

  def message_new_game
    puts '_________________________________________________'
    puts '+ ## ЧТОБЫ СЫГРАТЬ ЕЩЕ ИЛИ ВЫЙТИ НАЖМИТЕ Y/N ## +'
    case gets.chomp.upcase.to_s
    when 'Y'
      message(@game.balance_check)
      @game.new_game
      start_game
    when 'N'
      exit
    end
  end

  def open_cards
    puts "$$---БАНК #{@game.bank.bank}---$$"
    player_cards_points
    dealer_open_cards
    message_new_game
  end

  def  show_cards_bank_menu
    puts "$$---БАНК #{@game.bank.bank}---$$"
    player_cards_points
    dealer_cards_points
    puts
    puts 'ВЫБЕРИТЕ ХОД: 1-Пропустить, 2-Добавить карту, 3-Открыть карты'
  end
end
