class Bank
  attr_reader :bank

  def initialize
    @bank = 0
  end

  def add_money
    @bank += 20
  end

  def refund
    @bank -= 20
  end
end
