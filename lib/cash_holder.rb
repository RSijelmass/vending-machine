class CashHolder
  COIN_TYPES = [200, 100, 50, 20, 10, 5, 2, 1]
  DEFAULT_COINS_INPUT = { 200 => 5, 100 => 5, 50 => 5, 20 => 5, 10 => 5, 5 => 5, 2 => 5, 1 => 5 }
  attr_reader :coins_wallet

  def initialize(coins_wallet=DEFAULT_COINS_INPUT)
    @coins_wallet = coins_wallet
  end

  def get_total_value
    @coins_wallet.inject(0) do |total_value, (coin, amount)|
      total_value += coin * amount
    end
  end

  def store_funds(given_coins, price_of_item)
    sum_coins = given_coins.inject(0, :+)
    assert_validity_storing_funds(given_coins, price_of_item, sum_coins)

    add_coins_to_wallet(given_coins)

    total_to_return = sum_coins - price_of_item
    return_change(given_coins, total_to_return)
  end

  def top_up_coins(coins_to_add)
    raise "Not all coins are accepted. No coins have been topped up." unless coins_to_add.all? { |coin, amount| COIN_TYPES.include? coin }
    @coins_wallet.merge!(coins_to_add) { |k, wallet, to_add| wallet + to_add }
  end

  private

  def add_coins_to_wallet(given_coins)
    given_coins.each do |coin|
      @coins_wallet[coin] ? @coins_wallet[coin] += 1 : @coins_wallet[coin] = 1
    end
  end

  def assert_validity_storing_funds(given_coins, price_of_item, sum_coins)
    raise "Some coins provided are not allowed." if given_coins.any?(&:negative?)
    raise "Given funds cannot be less than the item price." if price_of_item > sum_coins
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

    print_lack_of_change(total_to_return) if total_to_return > 0

    change_list
  end

  def print_lack_of_change(total_to_return)
    puts "Could not return full amount - #{total_to_return}p has not been returned due to missing change."
  end
end
