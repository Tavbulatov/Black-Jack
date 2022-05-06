# frozen_string_literal: true

class Dealer < Player
  attr_accessor :poits, :purse, :rand_cards

  def initialize(name = 'Dealer')
    super
  end

  def add_cards(card)
    if @rand_cards.flatten.size >= 3
      puts 'У ДИЛЛЕРА УЖЕ ЕСТЬ ТРИ КАРТЫ'
    elsif @poits < 17
      @rand_cards << card
      count_points
      change_ace_value
      puts '+ ## ДИЛЛЕР ВЗЯЛ ОДНУ КАРТУ ## +' if card.size == 1
      puts
      puts '+ ## ХОД ПЕРЕХОДИТ К ИГРОКУ ## +' if card.size == 1
    elsif @poits >= 17
      puts '+ ## ДИЛЛЕР ПРОПУСТИЛ ХОД ## +'
      puts '+ ## ХОД ПЕРЕХОДИТ К ИГРОКУ ## +'
    end
  end

  def open_cards
    puts 'КАРТЫ ДИЛЛЕРА'
    @rand_cards.flatten.each { |card| print card.suit }
    puts
    puts "ОЧКИ: #{@poits} БАНК: #{@purse}"
  end

  def cards_hands
    puts 'КАРТЫ ДИЛЛЕРА'
    puts '*' * @rand_cards.flatten.size
    puts "ОЧКИ: #{@poits} БАНК: #{@purse}"
  end
end
