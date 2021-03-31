class CashHolder
  COIN_TYPES = [200, 100, 50, 20, 10, 5, 2, 1]
  DEFAULT_COINS_INPUT = { 200 => 5, 100 => 5, 50 => 5, 20 => 5, 10 => 5, 5 => 5, 2 => 5, 1 => 5 }
  attr_reader :coins_wallet

  def initialize(coins_wallet=DEFAULT_COINS_INPUT)
    @coins_wallet = coins_wallet
  end

  def store_funds(given_coins, price_of_item)
    raise "Some coins provided are not allowed." if given_coins.any?(&:negative?)

    sum_coins = given_coins.inject(0, :+)
    raise "Given funds cannot be less than the item price." if price_of_item > sum_coins

    add_coins_to_wallet(given_coins)

    total_to_return = sum_coins - price_of_item
    return_change(given_coins, total_to_return)
  end

  private

  def add_coins_to_wallet(given_coins)
    given_coins.each do |coin|
      @coins_wallet[coin] ? @coins_wallet[coin] += 1 : @coins_wallet[coin] = 1
    end
  end

  def return_change(given_funds, total_to_return)
    change_list = []

    for coin_type in COIN_TYPES
      while @coins_wallet[coin_type] && @coins_wallet[coin_type] > 0 && total_to_return >= coin_type
        total_to_return -= coin_type
        @coins_wallet[coin_type]-= 1
        change_list << coin_type
      end
    end

    change_list
  end
end
