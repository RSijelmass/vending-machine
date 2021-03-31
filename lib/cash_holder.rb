class CashHolder
  attr_reader :current_value

  def initialize(current_value=0)
    @current_value = current_value
  end

  def store_funds(given_funds, price_of_item)
    raise "No negative funds allowed." if given_funds.negative?
    raise "Given funds cannot be less than the item price." if price_of_item > given_funds

    @current_value += price_of_item

    return_change(given_funds, price_of_item)
  end

  private

  def return_change(given_funds, price_of_item)
    given_funds - price_of_item
  end
end
