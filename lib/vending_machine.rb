class VendingMachine
  def initialize(products, cash_holder = CashHolder.new)
    @products = products
    @cash_holder = cash_holder
  end

  def select_product(product_name, money_input)
    product = find_product(product_name)
    raise "This item does not exist." unless product

    change = @cash_holder.store_funds(money_input, product.price)
    product.take_item

    { product: product, change: change }
  end

  def stock_product(product_name)
    product = find_product(product_name)
    product.replenish
  end

  private

  def find_product(product_name)
    @products.detect { |product| product.name == product_name }
  end
end
