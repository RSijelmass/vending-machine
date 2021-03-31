class CashHolder
  COIN_TYPES = [200, 100, 50, 20, 10, 5, 2, 1]
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
    total_change = given_funds - price_of_item
    change_list = []

    for coin_type in COIN_TYPES
      while total_change >= coin_type
        total_change -= coin_type
        change_list << coin_type
      end
    end

    change_list
  end
end
