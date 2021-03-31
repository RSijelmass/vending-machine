class Product
  attr_reader :name, :price, :amount
  MAX_CAPACITY = 3

  def initialize(name, price, amount=MAX_CAPACITY)
    @name = name
    @price = price
    @amount = amount
  end

  def take_item
    raise "Cannot take item; product is empty." unless @amount > 0
    @amount -= 1
  end
end
