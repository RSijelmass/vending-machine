class CashHolder
  attr_reader :current_value

  def initialize(current_value=0)
    @current_value = current_value
  end

  def store_funds(given_funds)
    raise "No negative funds allowed." if given_funds.negative?
    @current_value += given_funds
  end
end
