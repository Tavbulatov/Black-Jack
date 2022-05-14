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
    result = @game.automatic_check
    @game.awarding_prize(result)
    message_result(result)

    case gets.chomp.upcase.to_s
    when '1'
      message(@game.add_one_card_dealer)
      show_cards_bank_menu
      add_card_player_and_dealer
    when '2'
      message(@game.add_one_card_player)
      message(@game.add_one_card_dealer) if @game.player.poits < 21 # Чтобы когда у игрока очки > 21 диллер не взял карту,
      show_cards_bank_menu                   # так как @game.automatic_check - чекает игру на превышение очков у игрока,
      add_card_player_and_dealer             # а сам метод(он завернут в метод)вызывается после взятия игроками карт
    when '3'                                 # получается игра должна была закончится, а диллер взял карту.
      result = @game.count_results
      @game.awarding_prize(result) #подготовка призов так скажем
      message_result(result) # оглашение результатов с призами уже
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
      open_cards
    when @game.player
      puts '___________________________________________________'
      puts '            + ## ПОДВЕДЕНИЕ ИТОГОВ ## +'
      puts '|=================================================|'
      puts '__________________________________________________'
      puts '|       |-----+ ## ИГРОК ВЫИГРАЛ ## +-----|       |'
      puts '|_________________________________________________|'
      open_cards
    when @game.dealer
      puts '___________________________________________________'
      puts '            + ## ПОДВЕДЕНИЕ ИТОГОВ ## +'
      puts '|=================================================|'
      puts '___________________________________________________'
      puts '|       |----+ ## ДИЛЛЕР ВЫИГРАЛ ## +-----|       |'
      puts '|_________________________________________________|'
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
    puts "КАРТЫ ДИЛЛЕРА | ОЧКИ: #{@game.dealer.poits} | БАНК: #{@game.dealer.purse}"
    @game.dealer.cards.flatten.each { |card| print card.rank + card.suit }
    puts
  end

  def dealer_cards_poits
    puts "КАРТЫ ДИЛЛЕРА | ОЧКИ: ## | БАНК: #{@game.dealer.purse}"
    puts '*' * @game.dealer.cards.flatten.size
    puts
  end

  def player_cards_poits
    puts "КАРТЫ #{@game.player.name} | ОЧКИ: #{@game.player.poits} | БАНК: #{@game.player.purse}"
    @game.player.cards.flatten.each { |card| print card.rank + card.suit  }
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
    player_cards_poits
    dealer_open_cards
    message_new_game
  end

  def  show_cards_bank_menu
    puts "$$---БАНК #{@game.bank.bank}---$$"
    player_cards_poits
    dealer_cards_poits
    puts
    puts 'ВЫБЕРИТЕ ХОД: 1-Пропустить, 2-Добавить карту, 3-Открыть карты'
  end
end
